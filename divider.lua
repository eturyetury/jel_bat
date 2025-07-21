local divider = {}

sw, sh = love.graphics.getDimensions()

local rectW = 982.9147
local rectH = 442.466
local d1x = 170 + sw / 2 - (rectW / 2) - 20
local d1y = sh / 2 - rectH / 2 - 78.767 / 2 + 44
local d2x = d1x + 982.9147 + 40
local d2y = sh / 2 - (rectH / 2) - (78.767 / 2) + 44

function divider.draw()
    love.graphics.line(d1x, d1y, d2x, d2y)
end

return divider