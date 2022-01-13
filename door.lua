Entity = require("entity")
Door = Entity

function Door:new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, enabled)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.enabled = enabled
    setmetatable(object, {__index = Door})
    return object
end

function Door:OnBeginOverlap(other_entity, other_fixture, coll)
    if self.enabled then
        -- overlap logic
    end
end

return Door