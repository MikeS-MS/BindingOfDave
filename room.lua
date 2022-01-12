local sti = require("sti")
Room = {}

function Room:new(filename)
    local map = sti(filename)
    local object = {map = map, entities = {}}
    setmetatable(object, {__index = Room})
    return object
end

function Room:update(dt)
    self.map:update(dt)
end

function Room:draw()
    self.map:draw()
end