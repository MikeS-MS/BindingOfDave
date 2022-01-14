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
    debugLines = {},
    callback = nil,
    debug = false,
    showbounds = false
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

function Globals:drawDebugLine(start_pos, end_pos, color, timeToStay)
    if timeToStay == nil or timeToStay == 0 then
        timeToStay = 1
    end

    local line = {start_position = start_pos, end_pos = end_pos, color = color, time = love.timer.getTime(), timeToStay = timeToStay}
    table.insert(self.debugLines, line)
end

function Globals:draw()
    local removeRectangles = {}
    local removeLines = {}

    for x = 1, #self.debugRectangles do
        local rectangle = self.debugRectangles[x]
        if love.timer.getTime() < rectangle.time + rectangle.timeToStay and self.debug then
            love.graphics.setColor(rectangle.color.r, rectangle.color.g, rectangle.color.b)
            love.graphics.rectangle('fill', rectangle.position.x - rectangle.extent / 2, rectangle.position.y - rectangle.extent/2, rectangle.extent, rectangle.extent)
        else
            table.insert(removeRectangles, x)
        end
    end

    for x = 1, #self.debugLines do
        local line = self.debugLines[x]
        if love.timer.getTime() < line.time + line.timeToStay and self.debug then
            love.graphics.setColor(line.color.r, line.color.g, line.color.b)
            love.graphics.line(line.start_position.x, line.start_position.y, line.end_pos.x, line.end_pos.y)
        else
            table.insert(removeLines, x)
        end
    end

    for _, index in pairs(removeRectangles) do
        table.remove(self.debugRectangles, index)
    end

    for _, index in pairs(removeLines) do
        table.remove(self.debugLines, index)
    end

    if self.debug then
        love.graphics.setColor(255, 255, 255)
        love.graphics.print(math.ceil(1 / love.timer.getDelta()), 0, 0)
    end
    collectgarbage("collect")
end

return Globals