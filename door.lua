Door = {}


function Door:new(x, y, width, height, enabled)
    local object = {position = {x = x, y = y}, size = {width = width, height = height}, enabled = enabled}
    setmetatable(object, {__index = Door})
    return object
end

function Door:OnOverlap()
    if self.enabled then
        -- overlap logic
    end
end

return Door