Entity = {}
Entity.__index = Entity

function Entity:OnCollisionChanged(fixture)
    
end

function Entity:CreateCollision(x, y, world, width, height, scale, collision_expansion, collision_mode)
    if self.fixture ~= nil then
        local body = self.fixture:getBody()
        body:destroy()
    end
    
    local body = love.physics.newBody(world, x, y, 'dynamic')
    local shape = love.physics.newRectangleShape((width + collision_expansion.width) * scale.x, (height + collision_expansion.height) * scale.y)
    local fixture = love.physics.newFixture(body, shape)
    body:setFixedRotation(true)
    body:setUserData("entity")
    -- body:setUserData(self.id)
    fixture:setSensor(collision_mode)
    self.fixture = fixture
    self:OnCollisionChanged(fixture)
    return body
end

function Entity:SetLocation(x, y)
    self.fixture:getBody():setPosition(x, y)
end

function Entity.new(x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    local image = love.graphics.newImage(imagefilename)
    local width, height = image:getWidth(), image:getHeight()
    local object = setmetatable({velocity = {x = 600, y = 600}, image = image, rotation = 0, global_settings = global_settings, level = level, collision_expansion = collision_expansion, collision_mode = collision_mode}, Entity)
    local body = object:CreateCollision(
                                        x,
                                        y,
                                        world,
                                        width,
                                        height,
                                        global_settings.scale,
                                        collision_expansion,
                                        collision_mode)
    object.id = level:getAvailableID()
    return object
end

function Entity:OnBeginOverlap(other_entity, other_fixture, coll)

end

function Entity:OnScaleChanged(new_scale)
    local scale = {x = 1, y = 1}

    if new_scale.x ~= self.global_settings.scale.x or new_scale.y ~= self.global_settings.scale.y then
        scale.x = new_scale.x
        scale.y = new_scale.y
    end

    local body = self.fixture:getBody()
    body = self:CreateCollision(
                                body:getX(),
                                body:getY(),
                                self.global_settings.world,
                                self.image:getWidth() + self.collision_expansion.width,
                                self.image:getHeight() + self.collision_expansion.height,
                                scale,
                                self.collision_mode)

end

function Entity:Move(vx, vy)
    self.fixture:getBody():setLinearVelocity(vx, vy)
end

function Entity:getTransform()
    local x, y = self.fixture:getBody():getX(), self.fixture:getBody():getY()
    return {position = {x = x, y = y}, origin = {x = self.image:getWidth() / 2, y = self.image:getHeight() / 2}}
end

function Entity:getBoundingBox()
    return {size = {width = self.image:getWidth() * self.global_settings.scale.x, height = self.image:getHeight() * self.global_settings.scale.y}}
end

function Entity:getBoundingBoxUniform()
    local box = self:getBoundingBox()
    local bigger_size = box.size.height

    if box.size.width > box.size.height then
        bigger_size = box.size.width
    end

    return bigger_size
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