local dots = {
    spacingX = 52.861 + 13.571407142857142857142857142857,
    spacingY = 7
}

sw, sh = love.graphics.getDimensions()
local rectW   =   982.9147
local rectH   =   442.466
local d1x     =   168 + sw / 2 - (rectW / 2) + 56.861 / 2 
local d1y     =   sh / 2 - rectH / 2 - 78.767 / 2 + 36

love.graphics.setPointSize(2.2)

dots.dotTable = {}

for x = 0, 4 do
    for j = 0, 2 do
        for i = 0, 14 do
            table.insert(dots.dotTable, {
                x = d1x + i * dots.spacingX,
                y = d1y + j * dots.spacingY + x * 78.761
            })
        end
    end
 

end
function dots.draw()
    for _, d in ipairs(dots.dotTable) do 
        love.graphics.points(d.x, d.y)
    end
end

return dots