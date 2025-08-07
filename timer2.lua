
local timer2 = {
    x = 76,
    y = 25,
    width = 985.9147 / 2,
    duration   =   2.8,
    elapsed    =   0
}

timer2.barFull = timer2.width

function timer2.update(dt)
    timer2.elapsed = timer2.elapsed + dt
    if timer2.elapsed >= timer2.duration then
        timer2.elapsed = 0
    end

    local t = timer2.elapsed / timer2.duration
    timer2.currentWidth = timer2.width * (1 - t)
    timer2.currentX = timer2.x + (570 - timer2.x) * t
end

function timer2.draw()
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("fill", timer2.currentX, timer2.y, timer2.currentWidth, 5)
end

return timer2

