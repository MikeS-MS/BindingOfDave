Globals = {
    deltatime = 1,
    tile = {
        width = 32,
        height = 32
    },
    scale = {
        x = 1,
        y = 1
    },
    debugRectangles = {},
    callback = nil,
    debug = false
}

function Globals:SetCallback(callback)
    self.callback = callback
end

function Globals:OnScaleChangedCallback(new_scale)
    if self.callback ~= nil then
        self.callback(new_scale)
    end
end

function Globals:drawDebugRectangle(position, extent, color, timeToStay)
    if timeToStay == nil or timeToStay == 0 then
        timeToStay = 1
    end

    local rectangle = {position = position, extent = extent, color = color, time = love.timer.getTime(), timeToStay = timeToStay}
    table.insert(self.debugRectangles, rectangle)
end

function Globals:draw()
    local removeTable = {}

    for x = 1, #self.debugRectangles do
        local rectangle = self.debugRectangles[x]
        if rectangle.time + rectangle.timeToStay < love.timer.getTime() then
            love.graphics.setColor(rectangle.color)
            love.graphics.rectangle('fill', rectangle.position.x - rectangle.extent / 2, rectangle.position.y - rectangle.extent/2, rectangle.extent, rectangle.extent)
        else
            table.insert(removeTable, x)
        end
    end

    for _, index in pairs(removeTable) do
        table.remove(self.debugRectangles, index)
    end

    collectgarbage("collect")
end

return Globals