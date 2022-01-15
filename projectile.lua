local Entity = require("entity")
local Utilities = require("utilities")
Projectile = {}
Projectile.__index = Projectile
setmetatable(Projectile, Entity)

function Projectile.new(x, y, target_x, target_y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, room)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Projectile
    setmetatable(object, Projectile)
    object.type = "projectile"
    object.room = room
    object.direction = Utilities:getUnitDirection({x = x , y = y}, {x = target_x, y = target_y})
    object.range = 100
    return object
end

function Projectile:destroy()
    self.room:markForDestruction(self)
end

function Projectile:OnBeginOverlap(this_fixture, other_entity, other_fixture, coll)
    if other_entity ~= nil then
        if other_entity.type == "player" then
            print("bonk")
            self.room:markForDestruction(self)
        end
    elseif not other_fixture:isSensor() then
        self.room:markForDestruction(self)
    end
end

function Projectile:update(dt)
    local transform = self:getTransform()
    local new_velocity = Utilities:MultiplyVecByVec(self.direction, self.velocity)
    local new_location = Utilities:AddVecWithVec(transform.position, new_velocity)
    self:Move(0, 0)
    self:RotateToFacePosition(new_location.x, new_location.y)
    self:Move(new_velocity.x, new_velocity.y)
end

return Projectile