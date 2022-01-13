local Entity = require("entity")
Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player:OnCollisionChanged(fixture)
    fixture:getBody():setUserData("player")
end

function Player.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Player
    setmetatable(object, Player)
    return object
end

function Player:OnBeginOverlap(other_entity, other_fixture, coll)
    
end

function Player:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    self:RotateToFacePosition(mouseX, mouseY)
    self:Move(0, 0)
    local velocity = {x = 0, y = 0}
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