local Entity = require("entity")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player:OnCollisionChanged(fixture)

end

function Player.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    local object = Entity.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Player
    setmetatable(object, Player)
    object.type = "player"
    object.canShowBounds = true
    object.canDebug = true
    return object
end

function Player:OnBeginOverlap(this_fixture, other_entity, other_fixture, coll)

end

function Player:destroy()
    self.global_settings:Restart()
end

function Player:OnKeyReleased(key, scancode)
    if self.global_settings.can_debug then
        if key == "1" then
            self.canDebug = true
        end
        if key == "2" then
            self.canShowBounds = true
        end
    end
end

function Player:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    self:RotateToFacePosition(mouseX, mouseY)
    self:Move(0, 0)
    local velocity = {x = 0, y = 0}

    if self.global_settings.can_debug then
        if love.keyboard.isDown('1') and self.canDebug then
            self.level.global_settings.debug = not self.level.global_settings.debug
            self.canDebug = false
        end
        if love.keyboard.isDown('2') and self.canShowBounds then
            if self.level.global_settings.debug then
                self.level.global_settings.showbounds = not self.level.global_settings.showbounds
            end
            self.canShowBounds = false
        end
    end

    if love.keyboard.isDown('a') then
        velocity.x = self.velocity.x * -1
    end
    if love.keyboard.isDown('d') then
        velocity.x = self.velocity.x
    end
    if love.keyboard.isDown('w') then
        velocity.y = self.velocity.y * -1
    end
    if love.keyboard.isDown('s') then
        velocity.y = self.velocity.y
    end

    self:Move(velocity.x, velocity.y)
end

return Player