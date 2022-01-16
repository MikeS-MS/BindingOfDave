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
    body:setUserData(self)
    fixture:setSensor(collision_mode)
    self.fixture = fixture
    self:OnCollisionChanged(fixture)
    return body
end

function Entity.new(hp, damage, x, y, world, imagefilename, collision_expansion, collision_mode, global_settings, level)
    local image = love.graphics.newImage(imagefilename)
    local width, height = image:getWidth(), image:getHeight()
    local object = setmetatable({max_hp = hp, current_hp = hp, damage = damage, draw_health_bar = true, default_velocity = {x = 600, y = 600}, velocity = {x = 600 * global_settings.scale.x, y = 600 * global_settings.scale.y}, image = image, rotation = 0, global_settings = global_settings, level = level, collision_expansion = collision_expansion, collision_mode = collision_mode}, Entity)
    object:CreateCollision(
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

function Entity:hit(damage)
    local new_health = self.current_hp - damage

    if new_health > 0 then
        self.current_hp = new_health
        self:OnHit()
    else
        self.current_hp = 0
        self:destroy()
    end
end

function Entity:destroy()
    
end

function Entity:SetLocation(x, y)
    self.fixture:getBody():setPosition(x, y)
end

function Entity:getForwardVector()
    local angle = self.fixture:getBody():getAngle()
    local transform = self:getTransform()
    local magnitude = math.sqrt(math.pow(transform.position.x, 2) + math.pow(transform.position.y, 2))

    return {
        x = 0 * math.cos(angle) - 1 * math.sin(angle),
        y = 1 * math.cos(angle) + 0 * math.sin(angle)}
end

function Entity:OnBeginOverlap(this_fixture, other_entity, other_fixture, coll)

end

function Entity:OnEndOverlap(this_fixture, other_entity, other_fixture, coll)

end

function Entity:OnHit()

end

function Entity:updateVelocity(scale)
    self.velocity.x = self.default_velocity.x * scale.x
    self.velocity.y = self.default_velocity.y * scale.y
end

function Entity:OnScaleChanged(new_scale)
    local scale = {x = 1, y = 1}

    if new_scale.x ~= self.global_settings.scale.x or new_scale.y ~= self.global_settings.scale.y then
        scale.x = new_scale.x
        scale.y = new_scale.y
    end

    self:updateVelocity(scale)

    local body = self.fixture:getBody()
    body = self:CreateCollision(
                                body:getX(),
                                body:getY(),
                                self.level.currentRoom.world,
                                self.image:getWidth() + self.collision_expansion.width,
                                self.image:getHeight() + self.collision_expansion.height,
                                scale,
                                {width = 1, height = 1},
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
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
    local transform = self:getTransform()
    love.graphics.draw(self.image, transform.position.x, transform.position.y, self.rotation, self.global_settings.scale.x, self.global_settings.scale.y, transform.origin.x, transform.origin.y)

    if self.draw_health_bar then
        local health_bar_width, health_bar_height = 100 * self.global_settings.scale.x, 20 * self.global_settings.scale.y
        local divider = 20 * self.global_settings.scale.y
        local bar_pos = {x = transform.position.x - health_bar_width / 2, y = (transform.position.y - self.image:getHeight() / 2) - health_bar_height - divider}
        local hpPercent = self.current_hp / self.max_hp

        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
        love.graphics.rectangle('fill', bar_pos.x, bar_pos.y, health_bar_width, health_bar_height)
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 0))
        love.graphics.rectangle('fill', bar_pos.x, bar_pos.y, health_bar_width * hpPercent, health_bar_height)
    end
end

return Entity