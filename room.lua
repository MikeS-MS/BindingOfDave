local sti = require("sti")
local CollisionManager = require("collision")
local Enemy = require("enemy")
local Door = require("door")
local HealthPickup = require("health_pickup")
Room = {}

function Room:new(filename, room_settings, level, global_settings)
    local map = sti(filename)
    local world = love.physics.newWorld(0, 0)
    local object = {map = map, entities = {}, doors = {}, health_pickups_to_spawn = {}, room_settings = room_settings, enemy_spawn_locations = {}, entitiesToDestroy = {}, world = world, level = level, global_settings = global_settings, spawn_location = {x = 0, y = 0}, navigation_nodes_density = 50}
    setmetatable(object, {__index = Room})
    return object
end

function Room:load()
    if not self.loaded then
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
            elseif layer.name == "SpawnLocations" then
                local objects = layer.objects

                for y = 1, #objects do
                    local object = objects[y]

                    if object.properties.type == "player" then
                        self.spawn_location.x = object.x * self.global_settings.scale.x
                        self.spawn_location.y = object.y * self.global_settings.scale.y
                    elseif object.properties.type == "enemy" then
                        table.insert(self.enemy_spawn_locations, {x = object.x * self.global_settings.scale.x, y = object.y * self.global_settings.scale.y})
                    end
                end
            elseif layer.name == "DoorLocations" then
                local objects = layer.objects
                local side_positions = {}
                local teleport_side_positions = {}
                local width, height = love.graphics.getDimensions()
                local centerx, centery = width / 2, height / 2

                for y = 1, #objects do
                    local object = objects[y]
                    local position = {
                        x = object.x * self.global_settings.scale.x,
                        y = object.y * self.global_settings.scale.y
                    }
                    side_positions[object.properties.side] = position
                    teleport_side_positions[object.properties.side] = Utilities:AddVecWithVec(Utilities:MultiplyVecByNumber(Utilities:getUnitDirection(position, {x = centerx, y = centery}), 100 * self.global_settings.scale.x), position)
                end
                self.teleport_positions = teleport_side_positions
                self.door_positions = side_positions
            end
        end

        self:spawnEnemies()
        self:spawnDoors()
        self.loaded = true
    end
end

function Room:spawnEnemies()
    for x = 1, self.room_settings.difficulty do
        local width, height = love.graphics.getDimensions()
        local random_position = {x = width / 2, y = height / 2}

        if #self.enemy_spawn_locations > 0 then
            random_position = self.enemy_spawn_locations[math.random(#self.enemy_spawn_locations)]
        end

        local enemy = Enemy.new(self.room_settings.difficulty, 30, 10, random_position.x, random_position.y, self.world, "data/Enemy.png", {width = 0, height = 0}, false, self.global_settings, self.level, self)
        self:addEntity(enemy)
    end
end

function Room:spawnDoors()
    local room_settings = self.room_settings

    -- back door
    if not room_settings.is_first_room then
        local door_position = self.door_positions[room_settings.back_door_side]
        local angle = Room.getDoorAngle(room_settings.back_door_side)
        local door = Door.new(
            0,
            0,
            door_position.x,
            door_position.y,
            self.world,
            "data/Door.png",
            "data/DoorOpen.png",
            {width = 2, height = 2},
            true,
            self.global_settings,
            self.level,
            angle,
            true,
            room_settings.next_room_index - 2,
            room_settings.back_door_next_room_teleport)
        table.insert(self.doors, door)
    end

    -- front door
    if not room_settings.is_last_room then
        local door_position = self.door_positions[room_settings.front_door_side]
        local angle = Room.getDoorAngle(room_settings.front_door_side)
        local door = Door.new(
            0,
            0,
            door_position.x,
            door_position.y,
            self.world,
            "data/Door.png",
            "data/DoorOpen.png",
            {width = 2, height = 2},
            true,
            self.global_settings,
            self.level,
            angle,
            false,
            room_settings.next_room_index,
            room_settings.front_door_next_room_teleport)
        table.insert(self.doors, door)
    end
end

function Room.getDoorAngle(side)
    local rad_conversion = math.pi / 180
    if side == "left" then
        return -90 * rad_conversion
    elseif side == "right" then
        return 90 * rad_conversion
    elseif side == "bottom" then
        return 180 * rad_conversion
    end

    return 0
end

function Room:unload()
    self.world:destroy()
    self.world = love.physics.newWorld(0, 0)
end

function Room:activate(transitory_player)
    if transitory_player ~= nil then
        local inside = false

        for _, entity in pairs(self.entities) do
            if transitory_player.type == entity.type then
                inside = true
            end
        end

        if not inside then
            local transform = transitory_player:getTransform()
            transitory_player:CreateCollision(transform.position.x, transform.position.y, self.world, transitory_player.image:getWidth(), transitory_player.image:getHeight(), self.global_settings.scale, {width = 1, height = 1}, false)
            table.insert(self.entities, transitory_player)
        end
    end

    self.world:setCallbacks(BeginContact, EndContact, PreSolve, PostSolve)
end

function Room:deactivate()
    for x = 1, #self.entities do
        local entity = self.entities[x]
        local body = entity.fixture:getBody()
        local user_data = body:getUserData()
        if user_data ~= nil then
            if user_data.type == "player" then
                table.remove(self.entities, x)
                break
            end
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
    for _, e in pairs(self.entities) do
        if e.id == entity.id then
            return true
        end
    end
    return false
end

function Room:getEntity(id)
    for _, e in pairs(self.entities) do
        if e.id == id then
            return e
        end
    end
    return nil
end

function Room:isIDAvailable(id)
    for _, entity in pairs(self.entities) do
        if id == entity.id then
            return false
        end
    end
    return true
end

function Room:rayCast(start_location, end_location, ignored_entity, single_scan, ignored_types)
    local hitlist = {}
    if self.world ~= nil then
        local bodies = self.world:getBodies()

        for _, body in pairs(bodies) do
            for _, fixture in pairs(body:getFixtures()) do
                local x, y, fraction = fixture:rayCast(start_location.x, start_location.y, end_location.x, end_location.y, 1)
                local user_data = body:getUserData()

                if user_data ~= nil then
                    if user_data.id ~= ignored_entity.id then
                        local proceed = true

                        for _, type in pairs(ignored_types) do
                            if user_data.type == type then
                                proceed = false
                                break
                            end
                        end

                        if x ~= nil and y ~= nil and proceed then
                            x = start_location.x + (end_location.x - start_location.x) * fraction
                            y = start_location.y + (end_location.y - start_location.y) * fraction
                            local hit = {
                                position = {
                                    x = x,
                                    y = y
                                },
                                distance = Utilities:getDistanceUniform(start_location, {x = x, y = y}),
                                fixture = fixture,
                                entity = user_data
                            }
                            table.insert(hitlist, hit)
                        end
                    end
                else
                    if x ~= nil and y ~= nil then
                        x = start_location.x + (end_location.x - start_location.x) * fraction
                        y = start_location.y + (end_location.y - start_location.y) * fraction
                        local hit = {
                            position = {
                                x = x,
                                y = y
                            },
                            distance = Utilities:getDistanceUniform(start_location, {x = x, y = y}),
                            fixture = fixture,
                            entity = nil
                        }
                        table.insert(hitlist, hit)
                    end
                end
            end
        end
    end

    -- sort by distance
    table.sort(hitlist,
    function (a, b)
        if a.distance < b.distance then
            return true
        end
        return false
    end)

    if single_scan then
        if #hitlist > 0 then
            hitlist = {hitlist[1]}
        end
    end

    local start = {x = start_location.x, y = start_location.y}
    local time = 0.02

    if self.global_settings.debug then
        for x = 1, #hitlist do
            local hit = hitlist[x]
            self.global_settings:drawDebugLine(start_location, hit.position, {r = 0, g = 255, b = 0}, time)
            self.global_settings:drawDebugRectangle(hit.position, 10 * self.global_settings.scale.x, {r = 255, g = 0, b = 0}, time)
            start.x = hit.position.x
            start.y = hit.position.y
        end

        self.global_settings:drawDebugLine(start, end_location, {r = 255, g = 0, b = 0}, time)
        self.global_settings:drawDebugRectangle(end_location, 10 * self.global_settings.scale.x, {r = 255, g = 0, b = 0}, time)
    end

    return hitlist
end

function Room:isPointInsideSomething(x, y, extent)
    for _, body in pairs(self.world:getBodies()) do
        if not body:getUserData() then
            for _, fixture in pairs(body:getFixtures()) do
                local topLeftX, topLeftY, bottomRightX, bottomRightY = fixture:getBoundingBox()
                topLeftX = (topLeftX) - extent
                topLeftY = (topLeftY) - extent
                bottomRightX = (bottomRightX) + extent
                bottomRightY = (bottomRightY) + extent

                if Utilities:pointInRectangle({x = x, y = y}, {left = topLeftX, right = bottomRightX, top = topLeftY, bottom = bottomRightY}) then
                    return true
                end
            end
        end
    end
    return false
end

function Room:spawnHealthPickup(health)
    local width, height = love.graphics.getDimensions()
    local random_location = {x = 0, y = 0}

    repeat
        random_location.x = math.random(width)
        random_location.y = math.random(height)
    until not self:isPointInsideSomething(random_location.x, random_location.y, 0)

    table.insert(self.health_pickups_to_spawn, {health = 0, damage = health, x = random_location.x, y = random_location.y, imagefilename = "data/HealthPickup.png", collision_expansion = {width = 1, height = 1}, collision_mode = true})
end

function Room:spawnAllPickups()
    local needs_cleaning = false

    for _, pickup in pairs(self.health_pickups_to_spawn) do
        local hp_pickup = HealthPickup.new(
            pickup.health,
            pickup.damage,
            pickup.x,
            pickup.y,
            self.world,
            pickup.imagefilename,
            pickup.collision_expansion,
            pickup.collision_mode,
            self.global_settings,
            self.level,
            self)
        self:addEntityToList(hp_pickup)
        needs_cleaning = true
    end

    self.health_pickups_to_spawn = {}
    if needs_cleaning then
        collectgarbage("collect")
    end
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

function Room:OnEntitiesKilled()
    local can_open_door = true
    for _, entity in pairs(self.entities) do
        if entity.type == "enemy" then
            can_open_door = false
            break
        end
    end

    if can_open_door then
        if self.room_settings.is_last_room then
            self.global_settings:Restart()
        end
        for _, door in pairs(self.doors) do
            door.enabled = true
        end
    end
end

function Room:doesEntityExistInRoom(entity)
    if entity ~= nil then
        for x = 1, #self.entities do
            local e = self.entities[x]
            if e.id == entity.id then
                return true, x
            end
        end
    end
    return false
end

function Room:markForDestruction(entity)
    if entity ~= nil then
        local success, index = self:doesEntityExistInRoom(entity)
        if success then
            table.insert(self.entitiesToDestroy, index)
        end
    end
end

function Room:destroyEntities()
    local entities = {}
    local needs_cleaning = false

    for _, index in pairs(self.entitiesToDestroy) do
        local entity = self.entities[index]
        if entity.fixture ~= nil then
            local body = entity.fixture:getBody()
            body:destroy()
        end
        table.insert(entities, entity)
        needs_cleaning = true
    end

    for _, e in pairs(entities) do
        local success, index = self:doesEntityExistInRoom(e)

        if success then
            table.remove(self.entities, index)
        end
    end

    self.entitiesToDestroy = {}
    if needs_cleaning then
        collectgarbage("collect")
        self:OnEntitiesKilled()
    end
end

function BeginContact(fa, fb, coll)
    local fab, fbb = fa:getBody(), fb:getBody()
    local fab_data, fbb_data = fab:getUserData(), fbb:getUserData()

    if fab_data ~= nil then
        if fab_data.type then
            fab_data:OnBeginOverlap(fa, fbb_data, fb, coll)
        end
    end
    if fbb_data ~= nil then
        if fbb_data.type then
            fbb_data:OnBeginOverlap(fb, fab_data, fa, coll)
        end
    end
end

function EndContact(fa, fb, coll)
    local fab, fbb = fa:getBody(), fb:getBody()
    local fab_data, fbb_data = fab:getUserData(), fbb:getUserData()

    if fab_data ~= nil then
        if fab_data.type then
            fab_data:OnEndOverlap(fa, fbb_data, fb, coll)
        end
    end
    if fbb_data ~= nil then
        if fbb_data.type then
            fbb_data:OnEndOverlap(fb, fab_data, fa, coll)
        end
    end
end

function PreSolve(fa, fb, coll)

end

function PostSolve(fa, fb, coll, normalimpulse, tangentimpulse)

end

function Room:update(dt)
    self.map:update(dt)
    self:destroyEntities()
    self:spawnAllPickups()
    for _, entity in pairs(self.entities) do
        if entity ~= nil then
            entity:update(dt)
        end
    end

    for _, door in pairs(self.doors) do
        door:update(dt)
    end

    if self.world ~= nil then
        self.world:update(dt)
    end
end

function Room:drawDebug()
    for _, body in pairs(self.world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
            local data = body:getUserData()
            if data then
                if data.type == "enemy" then
                    if not fixture:isSensor() then
                        love.graphics.setColor(love.math.colorFromBytes(0, 255, 0))
                    else
                        love.graphics.setColor(love.math.colorFromBytes(0, 255, 255, 50))
                    end
                elseif data.type == "player" then
                    love.graphics.setColor(love.math.colorFromBytes(0, 255, 0))
                end
            else
                love.graphics.setColor(love.math.colorFromBytes(255, 0, 0))
            end
 
            love.graphics.polygon('fill', body:getWorldPoints(shape:getPoints()))
        end
    end
end

function Room:draw()
    self.map:draw(0, 0, self.global_settings.scale.x, self.global_settings.scale.y)

    local doors = self.doors

    for x = 1, #doors do
        local door = doors[x]

        door:draw()
    end

    for _, entity in pairs(self.entities) do
        if entity ~= nil then
            entity:draw()
        end
    end

    if self.global_settings.showbounds and self.global_settings.debug then
        self:drawDebug()
    end
end

return Room