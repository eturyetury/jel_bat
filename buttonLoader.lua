local buttonLoader = {
    corner = 5,
    width = 52.861,
    height = 24.4305,
    spacingX = 13.571407142857142857142857142857,
    spacingY = 25.6
}

sw, sh = love.graphics.getDimensions()
local rectW = 982.9147
local rectH = 328.744
local boxX = sw / 2 - (rectW / 2)
local boxY = sh / 2 - rectH / 2 - 78.767 / 2

buttonLoader.buttons = {}

for i = 0, 14 do
    table.insert(buttonLoader.buttons, {
        x = 170 + boxX + i * (buttonLoader.width + buttonLoader.spacingX),
        y = buttonLoader.height + buttonLoader.spacingY - 5
    })
end

function buttonLoader.draw()
    for _, t in ipairs(buttonLoader.buttons) do
        love.graphics.rectangle("line", t.x, t.y, buttonLoader.width, buttonLoader.height, buttonLoader.corner)
    end
end

return buttonLoader