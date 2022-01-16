local Entity = require("entity")
HealthPickup = {}
HealthPickup.__index = HealthPickup
setmetatable(HealthPickup, Entity)

function HealthPickup.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, room)
    local object = Entity.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = HealthPickup
    setmetatable(object, HealthPickup)
    object.type = "health_pickup"
    object.draw_health_bar = false
    object.room = room
    object.done = false
    return object
end

function HealthPickup:OnBeginOverlap(this_fixture, other_entity, other_fixture, coll)
    if not self.done then
        if other_entity ~= nil then
            if other_entity.type == "player" then
                local hp = other_entity.current_hp + self.damage
                if hp <= other_entity.max_hp then
                    other_entity.current_hp = hp
                else
                    other_entity.current_hp = other_entity.max_hp
                end
                self.done = true
                self.room:markForDestruction(self)
            end
        end
    end
end

return HealthPickup