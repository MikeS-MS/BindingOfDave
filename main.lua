local Player = require("Player")
local Level = require("level")
local gb = require("globals")

DEBUG = false

function love.load()
    gb:SetCallback(OnScaleChanged)
    love.physics.setMeter(32)
    gb.world = love.physics.newWorld(0, 0)

    -- load level
    CurrentLevel = Level:new({"data/rooms/Hub.lua"}, gb)
end

function OnScaleChanged(new_scale)
    if CurrentLevel ~= nil then
        CurrentLevel:OnScaleChanged(new_scale)
    end
end

function love.update(dt)
    if gb.world  ~= nil then
        gb.world:update(dt)
    end

    if CurrentLevel ~= nil then
        CurrentLevel:update(dt)
    end
end

function drawDebug()
    for _, body in pairs(gb.world:getBodies()) do
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
end

function love.draw()
    if CurrentLevel ~= nil then
        CurrentLevel:draw()
    end

    if DEBUG and gb.world ~= nil then
        drawDebug()
    end
end

