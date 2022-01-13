Level = {}

local sti = require("sti")
local CollisionManager = require("collision")
local Room = require("room")
local Player = require("player")


function Level:new(level_file, room_files, global_settings)
    local object = {currentRoom = nil, global_settings = global_settings, spawn_location = {x = 0, y = 0}, entities = {}}
    setmetatable(object, {__index = Level})
    local rooms = {}
    for __, room_file in pairs(room_files) do
        table.insert(rooms, Room:new(room_file, object, global_settings))
    end
    object.rooms = rooms
    object:setCurrentRoom(rooms[1], true)
    object:load()
    return object
end

function Level:setCurrentRoom(room, first)
    if self.currentRoom ~= nil then
        self.currentRoom:deactivate()
    end

    self.currentRoom = room

    local width, height = love.graphics.getDimensions()
    local scale = {x = 1, y = 1}

    scale.x = width / (room.map.width * self.global_settings.tile.width)
    scale.y = height / (room.map.height * self.global_settings.tile.height)

    self.global_settings:OnScaleChangedCallback(scale)

    if first then
        self:OnScaleChanged(scale, true)
    end

    self.global_settings.scale.x = scale.x
    self.global_settings.scale.y = scale.y

    self.currentRoom:load()
    if not first then
        self.currentRoom:activate(self.persistent_player)
    end
end

function Level:getAvailableID()
    local id = 0

    repeat
        id = math.random(10000)
    until self.currentRoom:isIDAvailable(id)

    return id
end

function Level:getAvailablePosition()
    if self.currentRoom ~= nil then
        return true, self.currentRoom:getAvailablePosition()
    end

    return false, {x = 0, y = 0}
end

function Level:OnScaleChanged(new_scale, skip)
    if self.persistent_player ~= nil then
        self.persistent_player:OnScaleChanged(new_scale)
    end

    if self.currentRoom ~= nil then
        self.currentRoom:OnScaleChanged(new_scale)
    end
end

function Level:load()
    if self.currentRoom then
        -- spawn player
        if not self.persistent_player then
            self.persistent_player = Player.new(
                                                self.currentRoom.spawn_location.x,
                                                self.currentRoom.spawn_location.y,
                                                self.currentRoom.world,
                                                "data/Player.png",
                                                {width = 0, height = 0},
                                                false,
                                                self.global_settings,
                                                self)
            self.currentRoom:activate(self.persistent_player)
        end
    end
    -- self:spawnMapCollisions()
end

function Level:AddEntity(entity)
    table.insert(self.entities, self.persistent_player)
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

    -- if self.persistent_player ~= nil then
    --     self.persistent_player:update(dt)
    -- end
end

function Level:draw()
    if self.currentRoom ~= nil then
        self.currentRoom:draw()
    end

    -- if self.persistent_player ~= nil then
    --     self.persistent_player:draw()
    -- end
end

return Level