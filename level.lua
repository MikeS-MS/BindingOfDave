Level = {}

local sti = require("sti")
local CollisionManager = require("collision")
local Player = require("player")


function Level:new(room_files, global_settings)
    local rooms = {}

    for x = 1, #room_files do
        local room = sti(room_files[x])
        rooms[x] = room
    end

    local object = {rooms = rooms, currentRoom = nil, global_settings = global_settings, spawn_location = {x = 0, y = 0}, entities = {}}
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
    if scale.x < 1 and scale.y < 1 then
        self.currentRoom:resize(width + (width * scale.x), height + (height * scale.y))
    end
    -- self.global_settings:OnScaleChangedCallback(scale)
    self:OnScaleChanged(scale, true)
    self.global_settings.scale.x = scale.x
    self.global_settings.scale.y = scale.y

    self:unload()
    self:load()
end

function Level:OnScaleChanged(new_scale, skip)
    if self.persistent_player ~= nil then
        self.persistent_player:OnScaleChanged(new_scale)
    end
    if not skip then
        self:unload()
        self:load()
    end
end

function Level:load()
    if self.currentRoom then
        local layers = self.currentRoom.layers

        -- setup objects from map layers
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

        -- spawn player
        if not self.persistent_player then
            self.persistent_player = Player:new(
                                                self.spawn_location.x,
                                                self.spawn_location.y,
                                                self.global_settings.world,
                                                "data/Player.png",
                                                {width = 0, height = 0},
                                                false,
                                                self.global_settings,
                                                self,
                                                math.random(0, 10000))
            self:AddEntity(self.persistent_player)
        end
    end
    -- self:spawnMapCollisions()
end

function Level:AddEntity(entity)
    table.insert(self.entities, self.persistent_player)
end

function Level:unload()
    local bodies = self.global_settings.world:getBodies()
    local keep = {}

    for __, body in pairs(bodies) do
        print("bruh")
        if body:getUserData("player") then
            table.insert(keep, body)
        end
    end

    self.global_settings.world:destroy()
    self.global_settings.world = love.physics.newWorld(0, 0)
    for __, body in pairs(keep) do
        bodies = self.global_settings.world:getBodies()

        table.insert(bodies, body)
    end

end

-- deprecated
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

function Level:BeginContact(fa, fb, coll)
    local fab, fbb = fa:getBody(), fb:getBody()
    local entity_a, entity_b = nil, nil

    for __, entity in pairs(self.entities) do
        if fab:getUserData("entity") and fab:getUserData(entity.id) then
            entity_a = entity
        end
        if fbb:getUserData("entity") and fbb:getUserData(entity.id) then
            entity_b = entity
        end
    end

    if entity_a ~= nil then
        entity_a:OnBeginOverlap(entity_b, fab, coll)
    end

    if entity_b ~= nil then
        entity_b:OnBeginOverlap(entity_a, fbb, coll)
    end
end

function Level:EndContact(fa, fb, coll)

end

function Level:PreSolve(fa, fb, coll)

end

function Level:PostSolve(fa, fb, coll, normalimpulse, tangentimpulse)

end

function Level:update(dt)
    if self.currentRoom ~= nil then
        self.currentRoom:update(dt)
    end

    if self.persistent_player ~= nil then
        self.persistent_player:update(dt)
    end
end

function Level:draw()
    if self.currentRoom ~= nil then
        self.currentRoom:draw(0, 0, self.global_settings.scale.x, self.global_settings.scale.y)
    end

    if self.persistent_player ~= nil then
        self.persistent_player:draw()
    end
end

return Level