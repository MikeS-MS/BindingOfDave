local Entity = require("entity")
local Projectile = require("projectile")
local Utilities = require("utilities")

Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, Entity)

function Enemy.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, room)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Enemy
    setmetatable(object, Enemy)
    object.room = room
    object.navigation_nodes = {}
    object.type = "enemy"
    object:spawnNavigation()
    object:getPatrolLocations()
    object.shouldMove = true
    object.canShoot = true
    object.time_shot = 0
    object.shoot_cd = 3
    object.velocity.x = 300
    object.velocity.y = 300
    object.playerLocation = {x = 0, y = 0}
    object.range = 800
    return object
end

function Enemy:destroy()
    self.room:markForDestruction(self)
end

function Enemy:OnBeginOverlap(other_entity, other_body, coll)
    self:getPatrolLocations()
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
                    table.insert(row, {position = {x = currentX, y = currentY}, g = 0, h = 0, blocked = true})
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

        -- add neighbours
        for y = 1, nav_columns - 1 do
            for x = 1, nav_rows - 1 do
                local point = self.navigation_nodes[y][x]
                point.neighbours = {}

                -- check for left
                if x - 1 > 1 then
                   table.insert(point.neighbours, self.navigation_nodes[y][x-1])
                end

                -- check for right
                if x + 1 < nav_rows then
                    table.insert(point.neighbours, self.navigation_nodes[y][x+1])
                end

                -- check for top
                if y - 1 > 1 then
                    table.insert(point.neighbours, self.navigation_nodes[y-1][x])
                end

                -- check for bottom
                if y + 1 < nav_columns then
                    table.insert(point.neighbours, self.navigation_nodes[y+1][x])
                end

                -- check topleft
                if x - 1 > 1 and y - 1 > 1 then
                    table.insert(point.neighbours, self.navigation_nodes[y-1][x-1])
                end
                
                -- check bottomleft
                if x - 1 > 1 and y + 1 < nav_columns then
                    table.insert(point.neighbours, self.navigation_nodes[y+1][x-1])
                end

                -- check topright
                if x + 1 < nav_rows and y - 1 > 1 then
                    table.insert(point.neighbours, self.navigation_nodes[y-1][x+1])
                end

                -- check bottomright
                if x + 1 < nav_rows and y + 1 < nav_columns then
                    table.insert(point.neighbours, self.navigation_nodes[y+1][x+1])
                end
            end
        end

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
    local x, y = 1, 1

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
    return point_index
end

function Enemy.getDistanceToTarget(start_location, target_location)
    local distance = Utilities:getDistance(start_location, target_location)

    local lowest = math.min(distance.x, distance.y)
    local highest = math.max(distance.x, distance.y)

    local horizontalMovesReq = highest - lowest

    return lowest * 14 + horizontalMovesReq * 10
end

function Enemy.isPointInTable(point, table)
    for _, node in pairs(table) do
        if node == point then
            return true
        end
    end
    return false
end

-- A* Pathfinding algorithm
function Enemy:pathFindToLocation(start_location, target_location)
    -- get closest location from nodes
    local start_location_index, target_location_index = self:getClosestNavPoint(start_location), self:getClosestNavPoint(target_location)
    local start_location_nav, target_location_nav = self.navigation_nodes[start_location_index.y][start_location_index.x], self.navigation_nodes[target_location_index.y][target_location_index.x]

    -- evaluate score
    start_location_nav.h = Enemy.getDistanceToTarget(start_location_nav.position, target_location)
    start_location_nav.g = 0
    start_location_nav.f = start_location_nav.g + start_location_nav.h
    local toSearch = {start_location_nav}
    local visited = {}

    -- clear connections
    for _, node in pairs(self.navigation_nodes) do
        node.connection = nil
    end

    local empty = #toSearch

    while empty ~= 0 do
        local current = toSearch[1]
        local currentIndex = 1

        for x = 1, #toSearch do
            local node = toSearch[x]
            node.h = Enemy.getDistanceToTarget(node.position, target_location)
            node.g = Enemy.getDistanceToTarget(current.position, node.position)
            node.f = node.g + node.h

            if node.f < current.f or node.f == current.f and node.h < current.h then
                current = node
                currentIndex = x
            end
        end

        table.insert(visited, current)
        table.remove(toSearch, currentIndex)

        if current == target_location_nav then
            local currentPathNode = target_location_nav
            local path = {}

            while currentPathNode ~= start_location_nav do
                table.insert(path, currentPathNode.position)
                currentPathNode = currentPathNode.connection
            end

            return Utilities:reverseTable(path)
        end

        for y = 1, #current.neighbours do
            local neighbour = current.neighbours[y]
            if not neighbour.blocked and not Enemy.isPointInTable(neighbour, visited) then
                local inSearch = Enemy.isPointInTable(neighbour, toSearch)

                local costToNeighbour = current.g + Enemy.getDistanceToTarget(current.position, neighbour.position)

                if not inSearch or costToNeighbour < neighbour.g then
                    neighbour.g = costToNeighbour
                    neighbour.connection = current

                    if not inSearch then
                        neighbour.h = Enemy.getDistanceToTarget(neighbour.position, target_location_nav.position)
                        table.insert(toSearch, neighbour)
                    end
                end
            end
        end

        empty = #toSearch
    end
end

-- old pathfinding algorithm
function Enemy:pathFindToLocation2(start_location, target_location)
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

function Enemy:getPatrolLocations()
    local transform = self:getTransform()
    local position = self:getAvailablePosition()
    self.positions = self:pathFindToLocation(transform.position, position)

    if position ~= nil and self.positions ~= nil then
        self.position = self.positions[1]
        self.pos_index = 1
        -- draw debug for paths
        if self.level.global_settings.debug then
            for x = 1, #self.positions do
                local nav_position = self.positions[x]
                local color = {r = 255, g = 255, b = 0}

                if x == #self.positions then
                    color = {r = 0, g = 255, b = 0}
                end

                self.level.global_settings:drawDebugRectangle(nav_position, 10, color, 2)
            end
        end
    end
end

function Enemy:spotPlayer()
    local transform = self:getTransform()
    local forward_vector = self:getForwardVector()
    local end_pos = Utilities:AddVecWithVec(transform.position, Utilities:MultiplyVecByNumber(forward_vector, self.range * self.level.global_settings.scale.x))
    local hitresults = self.room:rayCast(transform.position, end_pos, self, true, "projectile")
    self.found_player = false
    self.shouldMove = true

    for _, hit in pairs(hitresults) do
        if hit.entity ~= nil then
            if hit.entity.type == "player" then
                self.found_player = true
                self.shouldMove = false
            end
        end
    end
end

function Enemy:shoot(position)
    if self.canShoot then
        local transform = self:getTransform()
        local projectile = Projectile.new(transform.position.x, transform.position.y, position.x, position.y, self.room.world, "data/Player.png", {width = 0, height = 0}, true, self.global_settings, self.level, self.room)
        self.room:addEntityToList(projectile)
        self.time_shot = love.timer.getTime()
        self.canShoot = false
    end
end

function Enemy:update(dt)
    self:Move(0, 0)
    self:spotPlayer()

    if not self.canShoot then
        if love.timer.getTime() >= self.time_shot + self.shoot_cd then
            self.canShoot = true
        end
    end

    if self.shouldMove then
        local transform = self:getTransform()
        local point_size = self.room.navigation_nodes_density

        if self.positions ~= nil then
            if #self.positions ~= 0 then
                if not Utilities:pointInRectangle({x = transform.position.x, y = transform.position.y}, {left = self.position.x - point_size / 2, right = self.position.x + point_size / 2, top = self.position.y - point_size / 2, bottom = self.position.y + point_size / 2}) then
                    local direction = Utilities:getUnitDirection(transform.position, self.position)
                    self:RotateToFacePosition(self.position.x , self.position.y)
                    self:Move(self.velocity.x * direction.x, self.velocity.y * direction.y)
                else
                    self.pos_index = self.pos_index + 1
                    if self.positions[self.pos_index] then
                        self.position = self.positions[self.pos_index]
                    else
                        self:getPatrolLocations()
                    end
                end
            else
                self:getPatrolLocations()
            end
        end
    elseif self.found_player then
        local playerTransform = self.level.persistent_player:getTransform()
        self:RotateToFacePosition(playerTransform.position.x, playerTransform.position.y)
        self:shoot(playerTransform.position)
    end
end

return Enemy