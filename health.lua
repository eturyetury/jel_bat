local health = {}
lg = love.graphics
local gameState = require("gameState")





local barPX = {
    x = 157.1,
    y = 565,
    length = 175,
    width = 5,
    spacing = 216.93   --spacing is 41.93
}

local playerIconPX = {
    x = 244.6,
    y = 520,
    radius = 25,
    spacing = 216.93
}

local healthBars = {

}

function health.draw()
    local x = barPX.x
    lg.setLineWidth(1)
    for _, i in ipairs(gameState.players) do
        lg.setColor(i.color)
        lg.rectangle("fill", x, barPX.y, barPX.length, barPX.width)
        x = x + barPX.spacing
    end
end

function health.icons()
    local x = playerIconPX.x
    for _, i in ipairs(gameState.players) do
        lg.setColor(i.color)
        lg.circle("line", x, playerIconPX.y, playerIconPX.radius)
        x = x + playerIconPX.spacing
    end
end

    

return health