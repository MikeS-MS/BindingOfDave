local Player = require("Player")
local Level = require("level")
local gb = require("globals")

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

function love.load()
    gb:SetCallback(OnScaleChanged)
    love.physics.setMeter(32)
    -- load level
    CurrentLevel = Level:new(nil, {"data/rooms/Hub.lua"}, gb)
end

function OnScaleChanged(new_scale)
    if CurrentLevel ~= nil then
        CurrentLevel:OnScaleChanged(new_scale)
    end
end

function love.update(dt)
    gb.deltatime = dt
    if CurrentLevel ~= nil then
        CurrentLevel:update(dt)
    end
end

function love.draw()
    if CurrentLevel ~= nil then
        CurrentLevel:draw()
    end
end

