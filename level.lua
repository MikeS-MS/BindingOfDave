Level = {}

local sti = require("sti")
local CollisionManager = require("collision")

function Level:new(room_files, global_settings)
    local rooms = {}

    for x = 1, #room_files do
        local room = sti(room_files[x], {"box2d"})
        rooms[x] = room
    end

    local object = {rooms = rooms, currentRoom = nil, global_settings = global_settings, spawn_location = {x = 0, y = 0}}
    setmetatable(object, {__index = Level})
    object:setCurrentRoom(rooms[1])
    return object
end

function Level:setCurrentRoom(room)
    self.currentRoom = room
    local width, height = love.graphics.getDimensions()
    local scale = {x = 1, y = 1}
    scale.x = width / (room.width * self.global_settings.tile.width)
    scale.y = height / (room.height * self.global_settings.tile.height)
    self.global_settings:OnScaleChangedCallback(scale)
    self:OnScaleChanged(scale)
    self.global_settings.scale.x = scale.x
    self.global_settings.scale.y = scale.y

    self:unload()
    self:load()
end

function Level:OnScaleChanged(new_scale)
    self:unload()
    self:load()
end

function Level:load()
    if self.currentRoom then
        local layers = self.currentRoom.layers

        for x = 1, #layers do
            local layer = layers[x]
            if layer.name == "Collisions" then
                local objects = layer.objects

                for y = 1, #objects do
                    local object = objects[y]

                    CollisionManager:createCollisionObject(
                        object.x * self.global_settings.scale.x,
                        object.y * self.global_settings.scale.y,
                        object.width * self.global_settings.scale.x,
                        object.height * self.global_settings.scale.y,
                        self.global_settings.world,
                        'static'
                    )
                end
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
    -- self:spawnMapCollisions()
    -- self.currentRoom:initWorldCollision(self.global_settings.world)
end

function Level:unload()
    local bodies = self.global_settings.world:getBodies()

    for x = 1, #bodies do
        local body = bodies[x]
        if not body:getUserData("player") then
            body:destroy()
            bodies[x] = nil
        end
    end
end

function Level:spawnMapCollisions()
        local width, height = love.graphics.getDimensions()
        -- left
        CollisionManager:createCollisionObject(-100, 0, 100, height, self.global_settings.world)
        -- right
        CollisionManager:createCollisionObject(width, 0, 100, height, self.global_settings.world)
        -- top
        CollisionManager:createCollisionObject(0, -100, width, 100, self.global_settings.world)
        -- bottom
        CollisionManager:createCollisionObject(0, height, width, 100, self.global_settings.world)
end

function Level:update(dt)
    self.currentRoom:update(dt)
end

function Level:draw()
    self.currentRoom:draw(0, 0, self.global_settings.scale.x, self.global_settings.scale.y)
end

return Level