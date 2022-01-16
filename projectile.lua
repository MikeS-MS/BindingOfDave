local Entity = require("entity")
local Utilities = require("utilities")

Projectile = {}
Projectile.__index = Projectile
setmetatable(Projectile, Entity)

function Projectile.new(difficulty, hp, damage, x, y, target_x, target_y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, room, entity_id)
    local object = Entity.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Projectile
    setmetatable(object, Projectile)
    object.default_velocity = {x = object.default_velocity.x * (difficulty / 2), y = object.default_velocity.y * (difficulty / 2)}
    object:updateVelocity(global_settings.scale)
    object.draw_health_bar = false
    object.type = "projectile"
    object.room = room
    object.entity_id = entity_id
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
            -- hit player
            other_entity:hit(self.damage)
            self.room:spawnHealthPickup(self.damage)
            local enemy = self.room:getEntity(self.entity_id)
            if enemy ~= nil then
                enemy:hit(self.damage)
            end
            
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