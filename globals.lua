Globals = {
    world = nil,
    tile = {
        width = 32,
        height = 32
    },
    scale = {
        x = 1,
        y = 1
    },
    callback = nil
}

function Globals:SetCallback(callback)
    self.callback = callback
end

function Globals:OnScaleChangedCallback(new_scale)
    if self.callback ~= nil then
        self.callback(new_scale)
    end
end

return Globals