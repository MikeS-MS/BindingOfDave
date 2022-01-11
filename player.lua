Player = {}

function Player:CreateCollision(x, y, world, width, height, scale)
    local body = love.physics.newBody(
                                      world,
                                      x * scale.x,
                                      y * scale.y,
                                      'dynamic'
                                     )
    local shape = love.physics.newRectangleShape((width / 2) * scale.x, (height / 2) * scale.y)
    local fixture = love.physics.newFixture(body, shape)
    return body, shape, fixture
end

function Player:new(x, y, world, imagefilename, global_settings, level)
    local image = love.graphics.newImage(imagefilename)
    local width, height = image:getWidth(), image:getHeight()
    local bodywidth, bodyheight = (width / 2) / 1.2, (height / 2) / 1.2
    local body, shape, fixture = Player:CreateCollision(
                                                        (x - bodywidth / 2),
                                                        (y - bodyheight / 2),
                                                        world,
                                                        width / 1.2,
                                                        height / 1.2,
                                                        {x = 1, y = 1}
                                                        )
    body:setFixedRotation(true)
    body:setUserData("player")
    local object = {fixture = fixture, velocity = {x = 600, y = 600}, image = image, rotation = 0, global_settings = global_settings, level = level}
    setmetatable(object, {__index = Player})
    return object
end

function Player:OnScaleChanged(new_scale)
    -- cleanup
    local body = self.fixture:getBody()
    self.fixture:destroy()
    
    local scale = {x = 1, y = 1}

    if new_scale.x ~= self.global_settings.scale.x or new_scale.y ~= self.global_settings.scale.y then
        scale.x = new_scale.x
        scale.y = new_scale.y
    end

    local new_body, shape, fixture = self:CreateCollision(body:getX(), body:getY(), self.global_settings.world, self.image:getWidth(), self.image:getHeight(), scale)
    body:destroy()

    self.fixture = fixture
    body = new_body
    body:setFixedRotation(true)
    body:setUserData("player")
end

function Player:Move(vx, vy)
    self.fixture:getBody():setLinearVelocity(vx, vy)
end

function Player:getTransform()
    local x, y = self.fixture:getBody():getX(), self.fixture:getBody():getY()
    return {position = {x = x, y = y}, origin = {x = self.image:getWidth() / 2, y = self.image:getWidth() / 2}}
end

function Player:RotateToFacePosition(x, y)
    local transform = self:getTransform()
    local new_rot = math.atan2(x - transform.position.x, y - transform.position.y) * -1
    self.rotation = new_rot
    self.fixture:getBody():setAngle(new_rot)
end

function Player:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    self:RotateToFacePosition(mouseX, mouseY)
    self:Move(0, 0)
    local velocity = {x = 0, y = 0}
    if love.keyboard.isDown('a') then
        velocity.x = self.velocity.x * -1
    end
    if love.keyboard.isDown('d') then
        velocity.x = self.velocity.x
    end
    if love.keyboard.isDown('w') then
        velocity.y = self.velocity.y * -1
    end
    if love.keyboard.isDown('s') then
        velocity.y = self.velocity.y
    end
    self:Move(velocity.x, velocity.y)
end

function Player:draw()
    love.graphics.setColor(255, 255, 255)
    local transform = self:getTransform()
    love.graphics.draw(self.image, transform.position.x, transform.position.y, self.rotation, self.global_settings.scale.x, self.global_settings.scale.y, transform.origin.x, transform.origin.y*1.5)
end

return Player