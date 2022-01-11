CollisionManager = {}

function CollisionManager:createCollisionObject(x, y, width, height, world, mode)
    local body = love.physics.newBody(world, x + width / 2, y + height / 2, mode)
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(body, shape)
    return fixture
end

return CollisionManager