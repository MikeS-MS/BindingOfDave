local sti = require("sti")
local CollisionManager = require("collision")
local Room = require("room")
local Player = require("player")

Level = {}

function Level:new(level_file, global_settings)
    local object = {currentRoom = nil, global_settings = global_settings}
    setmetatable(object, {__index = Level})
    local settings = require(level_file)
    local rooms = {}
    local sides = {"left", "top", "right", "bottom"}

    math.randomseed(os.time())
    local back_door_next_room_teleport = ""
    local back_door_side = "left"

    for x = 1, #settings.rooms do
        local room_file = settings.rooms[x]
        local last_room = false
        local first_room = false
        local side_index = 1
        local front_door_side = ""

        repeat
            side_index = math.random(#sides)
            front_door_side = sides[side_index]
        until back_door_side ~= front_door_side

        if x == 1 then
            first_room = true
        elseif x == #settings.rooms then
            last_room = true
        end
        
        local front_door_next_room_teleport = ""
        if side_index > 2 then
            front_door_next_room_teleport = sides[side_index - 2]
        elseif side_index < 3 then
            front_door_next_room_teleport = sides[side_index + 2]
        end

        local room_settings = {
            is_first_room = first_room,
            is_last_room = last_room,
            next_room_index = x + 1,
            back_door_side = back_door_side,
            back_door_next_room_teleport = back_door_next_room_teleport,
            front_door_side = front_door_side,
            front_door_next_room_teleport = front_door_next_room_teleport,
            difficulty = settings.difficulty}

        table.insert(rooms, Room:new(room_file, room_settings, object, global_settings))
        back_door_side = front_door_next_room_teleport
        back_door_next_room_teleport = front_door_side
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

    if self.currentRoom ~= nil then
        repeat
            id = math.random(10000)
        until self.currentRoom:isIDAvailable(id)
    end

    return id
end

function Level:OnScaleChanged(new_scale, skip)
    if self.persistent_player ~= nil then
        self.persistent_player:OnScaleChanged(new_scale)
    end

    if self.currentRoom ~= nil then
        self.currentRoom:OnScaleChanged(new_scale)
    end
end

function Level:OnKeyReleased(key, scancode)
    if self.persistent_player ~= nil then
        self.persistent_player:OnKeyReleased(key, scancode)
    end
end

function Level:load()
    if self.currentRoom then
        -- spawn player
        if not self.persistent_player then
            self.persistent_player = Player.new(60,
                                                0,
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

function Level:update(dt)
    if self.currentRoom ~= nil then
        self.currentRoom:update(dt)
    end
end

function Level:draw()
    if self.currentRoom ~= nil then
        self.currentRoom:draw()
    end
end

return Level