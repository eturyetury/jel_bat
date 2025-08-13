local gameTiles = require("tiles")

local timer = {
    x = 1140 / 2 - 1,
    y = 25,
    width = 985.9147 / 2,

    duration = 2.8,
    elapsed = 0,
    revolutions = 0,
    paused = false,
    
    moveX = false,
    targetX = 570, 

    currentWidth = 0,
    currentX = 0
}

local timer2 = {
    x = 76,
    y = 25,
    width = 985.9147 / 2,
    duration   =   2.8,
    elapsed    =   0
}

timer.barFull = timer.width
timer2.barFull = timer2.width

function timer.update(dt)
    if not timer.paused then 
        timer.elapsed = timer.elapsed + dt
    end
    
    if timer.elapsed >= timer.duration then
        timer.elapsed = 0
        timer.revolutions = timer.revolutions + 1
        
        if gameTiles and gameTiles.gameButtons then
            for _, tile in ipairs(gameTiles.gameButtons) do
                tile.clicked = false
            end
        end
    end

    local t = timer.elapsed / timer.duration
    timer.currentWidth = timer.width * (1 - t)
    
    if timer.moveX then
        timer.currentX = timer.x + (timer.targetX - timer.x) * t
    else
        timer.currentX = timer.x
    end
    
    if not timer.paused then
        timer2.elapsed = timer2.elapsed + dt
    end

    if timer2.elapsed >= timer2.duration then
        timer2.elapsed = 0
    end

    local t = timer2.elapsed / timer2.duration
    timer2.currentWidth = timer2.width * (1 - t)
    timer2.currentX = timer2.x + (570 - timer2.x) * t
end

function timer.draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", timer.currentX, timer.y, timer.currentWidth, 5)
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("fill", timer2.currentX, timer2.y, timer2.currentWidth, 5)
end

function timer.pause()
    timer.paused = true
end

function timer.resume()
    timer.paused = false
end

function timer.reset()
    timer.elapsed = 0
    timer.revolutions = 0
end

function timer.setMovement(enable, targetX)
    timer.moveX = enable
    if targetX then
        timer.targetX = targetX
    end
end

function timer.getProgress()
    return timer.elapsed / timer.duration
end

function timer.getRemainingTime()
    return timer.duration - timer.elapsed
end

return timer