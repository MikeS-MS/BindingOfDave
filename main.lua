local Level = require("level")
local gb = require("globals")

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

function SetRestart()
    SHOULD_RESTART = true
end

function Restart()
    if CurrentLevel ~= nil then
        for _, room in pairs(CurrentLevel.rooms) do
            room:unload()
        end
    end
    CurrentLevel = nil
    collectgarbage("collect")
    CurrentLevel = Level:new("data.levels.persistent_level", gb)
end

function love.load()
    gb:SetCallback(OnScaleChanged)
    gb:SetRestartCallback(SetRestart)

    love.physics.setMeter(gb.tile.width)
    SHOULD_RESTART = true
end

function OnScaleChanged(new_scale)
    if CurrentLevel ~= nil then
        CurrentLevel:OnScaleChanged(new_scale)
    end
end

function love.keyreleased(key, scancode)
    if CurrentLevel ~= nil then
        CurrentLevel:OnKeyReleased(key, scancode)
    end
end

function love.update(dt)
    if SHOULD_RESTART then
        Restart()
        SHOULD_RESTART = false
    end
    gb.deltatime = dt
    if CurrentLevel ~= nil then
        CurrentLevel:update(dt)
    end
end

function love.draw()
    if CurrentLevel ~= nil then
        CurrentLevel:draw()
    end
    gb:draw()
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
end