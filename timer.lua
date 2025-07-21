local gameTiles = require("tiles")

local timer = {
    x = 1140 / 2 - 1,
    y = 25,
    width = 985.9147 / 2,
    duration   =   2.8,
    elapsed    =   0
    revolutions = 0
}

timer.barFull = timer.width

function timer.update(dt)
    timer.elapsed = timer.elapsed + dt
    if timer.elapsed >= timer.duration then
        timer.elapsed = 0
        timer.revolutions = timer.revolutions + 1
        for _, tile in ipairs (gameTiles.gameButtons) do
            tile.clicked = false
        end
    end

    local t = timer.elapsed / timer.duration
    timer.currentWidth = timer.width * (1 - t)
end

function timer.draw()
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("fill", timer.x, timer.y, timer.currentWidth, 5)
end

return timer

