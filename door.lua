local Entity = require("entity")
Door = {}
Door.__index = Door
setmetatable(Door, Entity)

function Door.new(hp, damage, x, y, world, imagefilename, openimagefilename, collision_expansion, collision_mode, global_settings, level, angle, enabled, room_id, teleport_side)
    local object = Entity.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Door
    setmetatable(object, Door)
    object.draw_health_bar = false
    object.fixture:getBody():setAngle(angle)
    object.open_image = love.graphics.newImage(openimagefilename)
    object.rotation = angle
    object.type = "door"
    object.room_id = room_id
    object.teleport_side = teleport_side
    object.enabled = enabled
    object.playerInside = false
    return object
end

function Door:OnBeginOverlap(this_fixture, other_entity, other_fixture, coll)
    if self.enabled then
        -- overlap logic
        if other_entity ~= nil then
            if other_entity.type == "player" and not self.playerInside then
                self.playerInside = true
            end
        end
    end
end

function Door:update(dt)
    if self.playerInside then
        self.level:setCurrentRoom(self.level.rooms[self.room_id])
        local teleport_location = self.level.currentRoom.teleport_positions[self.teleport_side]
        self.level.persistent_player:SetLocation(teleport_location.x, teleport_location.y)
        self.playerInside = false
    end
end

function Door:draw()
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
    local transform = self:getTransform()
    local image_to_draw = self.image
    if self.enabled then
        image_to_draw = self.open_image
    end
    love.graphics.draw(image_to_draw, transform.position.x, transform.position.y, self.rotation, self.global_settings.scale.x, self.global_settings.scale.y, transform.origin.x, transform.origin.y)
end

return Door