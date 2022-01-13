local Entity = require("entity")
local Utilities = require("utilities")

Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, Entity)

function Enemy.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, room)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Enemy
    setmetatable(object, Enemy)
    local transform = object:getTransform()
    object.room = room
    object.navigation_nodes = {}
    object:spawnNavigation()
    local position = object:getAvailablePosition()
    object.positions = object:pathFindToLocation(transform.position, position, object:getBoundingBoxUniform())
    object.position = object.positions[1]
    object.old_position = {x = -1, y = -1}
    object.pos_index = 1
    object.shouldMove = true
    object.velocity.x = 300
    object.velocity.y = 300
    return object
end

function Enemy:spawnNavigation()
    if not self.navigation_spawned then
        local width, height = love.graphics.getDimensions()
        local nav_rows, nav_columns = 0, 0
        local first = true
        local currentX, currentY = 0, 0
        local extent = self:getBoundingBoxUniform()

        while currentY <= height do
            local row = {}

            while currentX <= width do
                if self.room:isPointInsideSomething(currentX, currentY, extent / 2) then
                    table.insert(row, {position = {x = currentX, y = currentY}, blocked = true})
                else
                    table.insert(row, {position = {x = currentX, y = currentY}, blocked = false})
                end

                currentX = currentX + self.room.navigation_nodes_density

                if first then
                    nav_rows = nav_rows + 1
                end
            end

            self.navigation_nodes[nav_columns] = row
            first = false
            currentX = 0

            currentY = currentY + self.room.navigation_nodes_density
            nav_columns = nav_columns + 1
        end

        -- -- add neighbours
        -- for y = 1, nav_columns - 1 do
        --     for x = 1, nav_rows - 1 do
        --         local point = self.navigation_nodes[y][x]
        --         point.neigbours = {}
        --         if x - 1 > 1 then
        --            table.insert(point.neigbours, self.navigation_nodes[y][x-1])
        --         end

        --         if x + 1 < nav_rows then
        --             table.insert(point.neigbours, self.navigation_nodes[y][x+1])
        --         end

        --         if y - 1 > 1 then
        --             table.insert(point.neigbours, self.navigation_nodes[y-1][x])
        --         end

        --         if y + 1 < nav_columns - 1 then
        --             table.insert(point.neigbours, self.navigation_nodes[y+1][x])
        --         end
        --     end
        -- end

        self.navigation_rows = nav_rows
        self.navigation_columns = nav_columns
        self.navigation_spawned = true
    end
end

function Enemy:isPointBlocked(index)
    if self.navigation_nodes[index.y][index.x].blocked then
        return true
    end
    return false
end

function Enemy:getAvailablePosition()
    local x, y = 0, 0
    math.randomseed(os.time())

    repeat
        x = math.floor(math.random(1, self.navigation_rows - 1))
        y = math.floor(math.random(1, self.navigation_columns - 1))
    until not self:isPointBlocked({x = x, y = y})

    return self.navigation_nodes[y][x].position
end

function Enemy:getClosestNavPoint(location)
    local density = self.room.navigation_nodes_density / 2
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

function Enemy:pathFindToLocation(start_location, target_location, extent)
    -- get closest location from nodes
    local start_location_nav, target_location_nav = self:getClosestNavPoint(start_location), self:getClosestNavPoint(target_location)
    local nav_points = Utilities:deepcopy(self.navigation_nodes)
    -- change inaccessible points to blocked for the
    local target_location_from_nav = nav_points[target_location_nav.y][target_location_nav.x].position
    local end_points = {}
    local current_index = {}
    current_index.x = start_location_nav.x
    current_index.y = start_location_nav.y

    repeat
        local points = {}

        -- left point
        if current_index.x  - 1 > 0 then
            local success, point = Enemy.makePoint(current_index.x - 1, current_index.y, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- top point
        if current_index.y - 1 > 0 then
            local success, point = Enemy.makePoint(current_index.x, current_index.y - 1, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- right point
        if current_index.x + 1 < self.navigation_rows - 1 then
            local success, point = Enemy.makePoint(current_index.x + 1, current_index.y, nav_points, target_location_from_nav)
            if success then
                table.insert(points, point)
            end
        end

        -- bottom point
        if current_index.y + 1 < self.navigation_columns - 1 then
            local success, point = Enemy.makePoint(current_index.x, current_index.y + 1, nav_points, target_location_from_nav)
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

function Enemy.makePoint(x, y, nav_points, target_location_from_nav)
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

function Enemy:update(dt)
    if self.shouldMove then
        local transform = self:getTransform()
        local point_size = 50
        if self.positions then
                if not Utilities:pointInRectangle({x = transform.position.x, y = transform.position.y}, {left = self.position.x - point_size / 2, right = self.position.x + point_size / 2, top = self.position.y - point_size / 2, bottom = self.position.y + point_size / 2}) then
                    local direction = Utilities:getUnitDirection(transform.position, self.position)
                    self:RotateToFacePosition(self.position.x , self.position.y)
                    self:Move(self.velocity.x * direction.x, self.velocity.y * direction.y)
                    -- find new location if it got stuck
                    -- local new_transform = self:getTransform()
                    -- if new_transform.position.x == transform.position.x and new_transform.position.y == transform.position.y then
                    --     local position = self:getAvailablePosition()
                    --     self.positions = self:pathFindToLocation(transform.position, position, self:getBoundingBoxUniform())
                    --     self.position = self.positions[1]
                    --     self.pos_index = 1
                    -- end
                else
                    self.pos_index = self.pos_index + 1
                    if self.positions[self.pos_index] then
                        self.position = self.positions[self.pos_index]
                    else
                        local position = self:getAvailablePosition()
                        self.positions = self:pathFindToLocation(transform.position, position, self:getBoundingBoxUniform())
                        self.position = self.positions[1]
                        self.pos_index = 1
                    end
                end
        end
    end
end

function Enemy:draw()
    love.graphics.setColor(255, 255, 255)
    local transform = self:getTransform()
    love.graphics.draw(self.image, transform.position.x, transform.position.y, self.rotation, self.global_settings.scale.x, self.global_settings.scale.y, transform.origin.x, transform.origin.y)

    local point_size = 5
    for x = 1, #self.positions do
        local point = self.positions[x]
        if x < #self.positions then
            love.graphics.setColor(255, 255, 0)
        else
            love.graphics.setColor(0, 255, 0)
        end
        love.graphics.rectangle('fill', point.x - point_size / 2, point.y - point_size / 2, point_size, point_size)
    end
    love.graphics.setColor(255, 255, 255)
end

return Enemy