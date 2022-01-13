local Entity = require("entity")
local Utilities = require("utilities")

Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, Entity)


function Enemy.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    local object = Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    object.__index = Enemy
    setmetatable(object, Enemy)
    local transform = object:getTransform()
    local success, position = level:getAvailablePosition()
    object.positions = object.level.currentRoom:pathFindToLocation(transform.position, position)
    object.position = object.positions[1]
    object.pos_index = 1
    object.shouldMove = true
    object.velocity.x = 300
    object.velocity.y = 300
    return object
end

function Enemy:update(dt)
    if self.shouldMove then
        local transform = self:getTransform()
        local point_size = 50
        if not Utilities:pointInRectangle({x = transform.position.x, y = transform.position.y}, {left = self.position.x - point_size / 2, right = self.position.x + point_size / 2, top = self.position.y - point_size / 2, bottom = self.position.y + point_size / 2}) then
            local direction = Utilities:getUnitDirection(transform.position, self.position)
            self:RotateToFacePosition(self.position.x , self.position.y)
            self:Move(self.velocity.x * direction.x, self.velocity.y * direction.y)
        else
            self.pos_index = self.pos_index + 1
            if self.positions[self.pos_index] then
                self.position = self.positions[self.pos_index]
            else
                local success, position = self.level:getAvailablePosition()
                if success then
                    self.positions = self.level.currentRoom:pathFindToLocation(transform.position, position)
                    self.position = self.positions[1]
                    self.pos_index = 1
                end
            end
        end
    end
end

function Enemy:draw()
    love.graphics.setColor(255, 255, 255)
    local transform = self:getTransform()
    love.graphics.draw(self.image, transform.position.x, transform.position.y, self.rotation, self.global_settings.scale.x, self.global_settings.scale.y, transform.origin.x, transform.origin.y)

    love.graphics.setColor(255, 255, 0)
    local point_size = 5
    for _, point in pairs(self.positions) do
        love.graphics.rectangle('fill', point.x - point_size / 2, point.y - point_size / 2, point_size, point_size)
    end
end

return Enemy