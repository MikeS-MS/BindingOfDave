local Entity = require("entity")
Door = {}
Door.__index = Door
setmetatable(Door, Entity)

function Door:new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, enabled)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Door
    setmetatable(object, Door)
    object.enabled = enabled
    return object
end

function Door:OnBeginOverlap(other_entity, other_fixture, coll)
    if self.enabled then
        -- overlap logic
    end
end

return Door