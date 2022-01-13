local sti = require("sti")
local CollisionManager = require("collision")
local Enemy = require("enemy")
Room = {}

function Room:new(filename, level, global_settings)
    local map = sti(filename)
    local world = love.physics.newWorld(0, 0)
    local object = {map = map, entities = {}, world = world, level = level, global_settings = global_settings, spawn_location = {x = 0, y = 0}, navigation_spawned = false, navigation_nodes = {}, navigation_nodes_density = 50}
    setmetatable(object, {__index = Room})
    return object
end

function Room:load()
    local layers = self.map.layers
    -- setup objects from map layers
    for x = 1, #layers do
        local layer = layers[x]

        if layer.name == "Collisions" then
            local objects = layer.objects

            for y = 1, #objects do
                local object = objects[y]

                if object.visible then
                    CollisionManager:createCollisionObject(
                        object.x * self.global_settings.scale.x,
                        object.y * self.global_settings.scale.y,
                        object.width * self.global_settings.scale.x,
                        object.height * self.global_settings.scale.y,
                        self.world,
                        'static'
                    )
                end
            end
            self:spawnNavigation()
        end

        if layer.name == "SpawnLocations" then
            local objects = layer.objects

            for y = 1, #objects do
                local object = objects[y]

                if object.properties.type == "player" then
                    self.spawn_location.x = object.x * self.global_settings.scale.x
                    self.spawn_location.y = object.y * self.global_settings.scale.y
                end
            end
        end
    end
end

function Room:spawnNavigation()
    if not self.navigation_spawned then
        local width, height = love.graphics.getDimensions()
        local nav_rows, nav_columns = 0, 0
        local first = true
        local currentX, currentY = 0, 0

        while currentY <= height do
            local row = {}

            while currentX <= width do
                if self:isPointInsideSomething(currentX, currentY) then
                    table.insert(row, {position = {x = currentX, y = currentY}, blocked = true})
                else
                    table.insert(row, {position = {x = currentX, y = currentY}, blocked = false})
                end

                currentX = currentX + self.navigation_nodes_density

                if first then
                    nav_rows = nav_rows + 1
                end
            end

            self.navigation_nodes[nav_columns] = row
            first = false
            currentX = 0

            currentY = currentY + self.navigation_nodes_density
            nav_columns = nav_columns + 1
        end

        self.navigation_rows = nav_rows
        self.navigation_columns = nav_columns
        self.navigation_spawned = true
    end
end

function Room:getClosestNavPoint(location)
    local density = self.navigation_nodes_density / 2
    local point_index = {x = 1, y = 1}
    
    for y = 1, #self.navigation_nodes do
        local row = self.navigation_nodes[y]
        for x = 1, #row do
            local point = row[x]
            local bounding_box  = {
                left = point.position.x - density,
                right = point.position.x + density,
                top = point.position.y - density,
                bottom = point.position.y + density
            }

            if location.x >= bounding_box.left and location.x <= bounding_box.right and location.y >= bounding_box.top and location.y <= bounding_box.bottom then
                point_index.x = x
                point_index.y = y
                return point_index
            end
        end

    end
end

function Room.makePoint(x, y, nav_points, target_location_from_nav)
    local point = {}
    point.index = {}
    point.index.x = x
    point.index.y = y
    local point_entry = nav_points[point.index.y][point.index.x]
    point.position = {}
    point.position.x = point_entry.position.x
    point.position.y = point_entry.position.y
    if not point_entry.visited and not point_entry.blocked then
        point.distance = Utilities:getDistance(point.position, target_location_from_nav)
        point_entry.visited = true
        return true, point
    end
    return false, nil
end

function Room:pathFindToLocation(start_location, target_location)
    -- get closest location from nodes
    local start_location_nav, target_location_nav = self:getClosestNavPoint(start_location), self:getClosestNavPoint(target_location)
    local nav_points = Utilities:deepcopy(self.navigation_nodes)
    local target_location_from_nav = nav_points[target_location_nav.y][target_location_nav.x].position
    local end_points = {}
    local current_index = {}
    current_index.x = start_location_nav.x
    current_index.y = start_location_nav.y

    repeat
        local points = {}

        -- left point
        if current_index.x  - 1 > 0 then
            local success, point = Room.makePoint(current_index.x - 1, current_index.y, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- top point
        if current_index.y - 1 > 0 then
            local success, point = Room.makePoint(current_index.x, current_index.y - 1, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- right point
        if current_index.x + 1 <= self.navigation_rows - 1 then
            local success, point = Room.makePoint(current_index.x + 1, current_index.y, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- bottom point
        if current_index.y + 1 <= self.navigation_columns - 1 then
            local success, point = Room.makePoint(current_index.x, current_index.y + 1, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- get closest by distance
        local distance = {x = 1000000, y = 1000000}
        local point_pos = {x = target_location_from_nav.x, y = target_location_from_nav.y}
        local index = {x = target_location_nav.x, y = target_location_nav.y}
        
        for __, point in pairs(points) do
            if point.distance.x < distance.x or point.distance.y < distance.y then
                distance = point.distance
                point_pos.x = point.position.x
                point_pos.y = point.position.y
                index.x = point.index.x
                index.y = point.index.y
            end
        end

        current_index.x = index.x
        current_index.y = index.y
        table.insert(end_points, point_pos)
    until current_index.x == target_location_nav.x and current_index.y == target_location_nav.y

    return end_points
end

function Level:unload()
    self.world:destroy()
    self.world = love.physics.newWorld(0, 0)
end

function Room:activate(transitory_player)
    if transitory_player ~= nil then
        local inside = false

        for __, entity in pairs(self.entities) do
            if transitory_player.id == entity.id then
                inside = true
            end
        end
    
        if not inside then
            local transform = transitory_player:getTransform()
            transitory_player:CreateCollision(transform.position.x, transform.position.y, self.world, transitory_player.image:getWidth(), transitory_player.image:getHeight(), self.global_settings.scale, {width = 0, height = 0}, false)
            table.insert(self.entities, transitory_player)
        end

    end

    local enemy = Enemy.new(500, 500, self.world, "data/Player.png", {width = 0, height = 0}, false, self.global_settings, self.level)
    self:addEntity(enemy)
end

function Room:deactivate()
    for __, entity in self.entities do
        local body = entity.fixture:getBody()

        if body:getUserData("player") then
            table.remove(self.entities, entity)
            break
        end
    end
end

function Room:addEntity(new_entity)
    local inside = false

    for _, entity in pairs(self.entities) do
        if new_entity.id == entity.id then
            inside = true
        end
    end

    if not inside then
        table.insert(self.entities, new_entity)
    end
end

function Room:isEntityInList(entity)
    for __, e in pairs(self.entities) do
        if e.id == entity.id then
            return true
        end
    end
    return false
end

function Room:isIDAvailable(id)
    for __, entity in pairs(self.entities) do
        if id == entity.id then
            return false
        end
    end

    return true
end

function Room:getAvailablePosition()
    local x, y = 0, 0
    math.randomseed(os.time())

    repeat
        x = math.floor(math.random(1, self.navigation_rows - 1))
        y = math.floor(math.random(1, self.navigation_columns - 1))
    until not self:isPointBlocked({x = x, y = y})

    return self.navigation_nodes[y][x].position
end

function Room:isPointBlocked(index)
    if self.navigation_nodes[index.y][index.x].blocked then
        return true
    end
    return false
end

function Room:isPointInsideSomething(x, y)
    for _, body in pairs(self.world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            if fixture:testPoint(x, y) then
                return true
            end
        end
    end
    return false
end

function Room:addEntityToList(entity)
    if not self:isEntityInList(entity) then
        table.insert(self.entities, entity)
    end
end

function Room:OnScaleChanged(new_scale)
    local width, height = love.graphics.getDimensions()
    if new_scale.x < 1 and new_scale.y < 1 then
        self.map:resize(width + (width * new_scale.x), height + (height * new_scale.y))
    end
end

function Room:update(dt)
    self.map:update(dt)

    for _, entity in pairs(self.entities) do
        if entity ~= nil then
            entity:update(dt)
        end
    end

    if self.world ~= nil then
        self.world:update(dt)
    end
end

function Room:drawDebug()
    for _, body in pairs(self.world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
            if body:getUserData("shape") then
                love.graphics.setColor(0, 255, 0)
            else
                love.graphics.setColor(255, 0, 0)
            end
 
            love.graphics.polygon('fill', body:getWorldPoints(shape:getPoints()))
        end
    end
    local point_size = 5
    love.graphics.setColor(255, 255, 0)
    for __, row in pairs(self.navigation_nodes) do
        for _x, node in pairs(row) do
            if not node.blocked then
                love.graphics.rectangle('fill', node.position.x - point_size / 2, node.position.y - point_size / 2, point_size, point_size)
            end
        end
    end
end

function Room:draw()
    self.map:draw(0, 0, self.global_settings.scale.x, self.global_settings.scale.y)

    for __, entity in pairs(self.entities) do
        if entity ~= nil then
            entity:draw()
        end
    end

    if self.global_settings.debug then
        self:drawDebug()
    end
end

return Room