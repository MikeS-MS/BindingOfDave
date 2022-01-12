Entity = {}

function Entity:OnCollisionChanged(fixture)
    
end

function Entity:CreateCollision(x, y, world, width, height, scale, collision_mode)
    local body = love.physics.newBody(
                                      world,
                                      x * scale.x,
                                      y * scale.y,
                                      'dynamic'
                                     )
    local shape = love.physics.newRectangleShape(width * scale.x, height * scale.y)
    local fixture = love.physics.newFixture(body, shape)
    fixture:setSensor(collision_mode)
    self:OnCollisionChanged(fixture)
    return body, shape, fixture
end

function Entity:new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level, id)
    local image = love.graphics.newImage(imagefilename)
    local width, height = image:getWidth() + collision_expansion.width, image:getHeight() + collision_expansion.height
    local body, shape, fixture = Entity:CreateCollision(
                                                        x - (width / 2),
                                                        y - (height / 2),
                                                        world,
                                                        width,
                                                        height,
                                                        global_settings.scale,
                                                        collision_mode)
    body:setFixedRotation(true)
    body:setUserData("entity")
    local object = {fixture = fixture, velocity = {x = 600, y = 600}, image = image, rotation = 0, global_settings = global_settings, level = level, id = id, collision_expansion = collision_expansion, collision_mode = collision_mode}
    setmetatable(object, {__index = Entity})
    return object
end

function Entity:OnBeginOverlap(other_entity, other_fixture, coll)

end

function Entity:OnScaleChanged(new_scale)
    -- cleanup
    local body = self.fixture:getBody()
    self.fixture:destroy()

    local scale = {x = 1, y = 1}

    if new_scale.x ~= self.global_settings.scale.x or new_scale.y ~= self.global_settings.scale.y then
        scale.x = new_scale.x
        scale.y = new_scale.y
    end

    local new_body, shape, fixture = self:CreateCollision(
                                                          body:getX(),
                                                          body:getY(),
                                                          self.global_settings.world,
                                                          self.image:getWidth() + self.collision_expansion.width,
                                                          self.image:getHeight() + self.collision_expansion.height,
                                                          scale,
                                                          self.collision_mode)
    body:destroy()

    self.fixture = fixture
    body = new_body
    body:setFixedRotation(true)
    body:setUserData("entity")
end

function Entity:Move(vx, vy)
    self.fixture:getBody():setLinearVelocity(vx, vy)
end

function Entity:getTransform()
    local x, y = self.fixture:getBody():getX(), self.fixture:getBody():getY()
    return {position = {x = x, y = y}, origin = {x = self.image:getWidth() / 2, y = self.image:getHeight() / 2}}
end

function Entity:RotateToFacePosition(x, y)
    local transform = self:getTransform()
    local new_rot = math.atan2(x - transform.position.x, y - transform.position.y) * -1
    self.rotation = new_rot
    self.fixture:getBody():setAngle(new_rot)
end

function Entity:update(dt)

end

function Entity:draw()
    love.graphics.setColor(255, 255, 255)
    local transform = self:getTransform()
    love.graphics.draw(self.image, transform.position.x, transform.position.y, self.rotation, self.global_settings.scale.x, self.global_settings.scale.y, transform.origin.x, transform.origin.y)
end

return Entity