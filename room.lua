local sti = require("sti")
local CollisionManager = require("collision")
local Enemy = require("enemy")
Room = {}

function Room:new(filename, level, global_settings)
    local map = sti(filename)
    local world = love.physics.newWorld(0, 0)
    local object = {map = map, entities = {}, world = world, level = level, global_settings = global_settings, spawn_location = {x = 0, y = 0}, navigation_nodes_density = 50}
    setmetatable(object, {__index = Room})
    return object
end

function Room:load()
    local layers = self.map.layers
    -- setup objects from map layers
    for x = 1, #layers do
        local layer = layers[x]

        if layer.name == "Collisions" then
            local objects = layer.objects

            for y = 1, #objects do
                local object = objects[y]

                if object.visible then
                    CollisionManager:createCollisionObject(
                        object.x * self.global_settings.scale.x,
                        object.y * self.global_settings.scale.y,
                        object.width * self.global_settings.scale.x,
                        object.height * self.global_settings.scale.y,
                        self.world,
                        'static'
                    )
                end
            end
        end

        if layer.name == "SpawnLocations" then
            local objects = layer.objects

            for y = 1, #objects do
                local object = objects[y]

                if object.properties.type == "player" then
                    self.spawn_location.x = object.x * self.global_settings.scale.x
                    self.spawn_location.y = object.y * self.global_settings.scale.y
                end
            end
        end
    end
end

function Level:unload()
    self.world:destroy()
    self.world = love.physics.newWorld(0, 0)
end

function Room:activate(transitory_player)
    if transitory_player ~= nil then
        local inside = false

        for __, entity in pairs(self.entities) do
            if transitory_player.id == entity.id then
                inside = true
            end
        end

        if not inside then
            local transform = transitory_player:getTransform()
            transitory_player:CreateCollision(transform.position.x, transform.position.y, self.world, transitory_player.image:getWidth(), transitory_player.image:getHeight(), self.global_settings.scale, {width = 0, height = 0}, false)
            table.insert(self.entities, transitory_player)
        end
    end

    local enemy = Enemy.new(500, 500, self.world, "data/Player.png", {width = 0, height = 0}, false, self.global_settings, self.level, self)
    self:addEntity(enemy)
end

function Room:deactivate()
    for __, entity in self.entities do
        local body = entity.fixture:getBody()

        if body:getUserData("player") then
            table.remove(self.entities, entity)
            break
        end
    end
end

function Room:addEntity(new_entity)
    local inside = false

    for _, entity in pairs(self.entities) do
        if new_entity.id == entity.id then
            inside = true
        end
    end

    if not inside then
        table.insert(self.entities, new_entity)
    end
end

function Room:isEntityInList(entity)
    for __, e in pairs(self.entities) do
        if e.id == entity.id then
            return true
        end
    end
    return false
end

function Room:isIDAvailable(id)
    for _, entity in pairs(self.entities) do
        if id == entity.id then
            return false
        end
    end
    return true
end

function Room:isPointInsideSomething(x, y, extent)
    for _, body in pairs(self.world:getBodies()) do
        if not body:getUserData() then
            for _, fixture in pairs(body:getFixtures()) do
                local topLeftX, topLeftY, bottomRightX, bottomRightY = fixture:getBoundingBox()
                topLeftX = (topLeftX) - extent
                topLeftY = (topLeftY) - extent
                bottomRightX = (bottomRightX) + extent
                bottomRightY = (bottomRightY) + extent

                if Utilities:pointInRectangle({x = x, y = y}, {left = topLeftX, right = bottomRightX, top = topLeftY, bottom = bottomRightY}) then
                    return true
                end
            end
        end
    end
    return false
end

function Room:addEntityToList(entity)
    if not self:isEntityInList(entity) then
        table.insert(self.entities, entity)
    end
end

function Room:OnScaleChanged(new_scale)
    local width, height = love.graphics.getDimensions()
    if new_scale.x < 1 and new_scale.y < 1 then
        self.map:resize(width + (width * new_scale.x), height + (height * new_scale.y))
    end
end

function Room:update(dt)
    self.map:update(dt)

    for _, entity in pairs(self.entities) do
        if entity ~= nil then
            entity:update(dt)
        end
    end

    if self.world ~= nil then
        self.world:update(dt)
    end
end

function Room:drawDebug()
    for _, body in pairs(self.world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
            if body:getUserData("shape") then
                love.graphics.setColor(0, 255, 0)
            else
                love.graphics.setColor(255, 0, 0)
            end
 
            love.graphics.polygon('fill', body:getWorldPoints(shape:getPoints()))
        end
    end
    local point_size = 5
    love.graphics.setColor(255, 255, 0)
    for __, row in pairs(self.navigation_nodes) do
        for _x, node in pairs(row) do
            if not node.blocked then
                love.graphics.rectangle('fill', node.position.x - point_size / 2, node.position.y - point_size / 2, point_size, point_size)
            end
        end
    end
end

function Room:draw()
    self.map:draw(0, 0, self.global_settings.scale.x, self.global_settings.scale.y)

    for __, entity in pairs(self.entities) do
        if entity ~= nil then
            entity:draw()
        end
    end

    if self.global_settings.debug then
        self:drawDebug()
    end
end

return Room