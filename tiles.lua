

local gameTiles = {
    corner    =   12,
    width     =   52.861,                                                                                                                                                                                                
    height    =   52.861,
    spacingX  =   13.571407142857142857142857142857,
    spacingY  =   25.6
}



sw, sh = love.graphics.getDimensions()
local rectW  =   982.9147
local rectH  =   328.744
local boxX   =   sw / 2 - (rectW / 2)
local boxY   =   sh / 2 - rectH / 2 - 78.767 / 2


gameTiles.gameButtons = {}
gameTiles.gameItems = {}

--[[ PLAYER TILES ]]
for row = 0, 4 do
    for col = 0, 14 do
        table.insert(gameTiles.gameButtons, {
            x = 170 + boxX + col * (gameTiles.width + gameTiles.spacingX),
            y = boxY + row * (gameTiles.height + gameTiles.spacingY),
            hovered = false,
            clicked = false
        })
    end
end

--[[ ITEM TILES ]]
for itemRow =0, 5 do
    for itemCol = 0, 14 do
        table.insert(gameTiles.gameItems, {
            x = 170 + boxX + itemCol * (gameTiles.width + gameTiles.spacingX),
            y = boxY + itemRow * (gameTiles.height + gameTiles.spacingY),
            bomb        = false,
            airStrike   = false,
            laser       = false,
            mine        = false,
            shield      = false,
            freeze      = false,
            teleport    = false,
            health      = false,
            extraJump   = false,
            handBag     = false
        })
    end
end




function gameTiles.draw()
    for _, t in ipairs(gameTiles.gameButtons) do
        if t.clicked then
            love.graphics.setColor(0.3, 0.7, 1)
        elseif t.hovered then
            love.graphics.setColor(1,1,1)
            love.graphics.setLineWidth(5)
        else
            love.graphics.setColor(1,1,1,1)
            love.graphics.setLineWidth(1)
        end
        love.graphics.rectangle("line", t.x, t.y, gameTiles.width, gameTiles.height, gameTiles.corner)
    end
end

function gameTiles.update(dt)
    local mx, my = love.mouse.getPosition()
    for _, tile in ipairs(gameTiles.gameButtons) do
        tile.hovered = 
            mx >= tile.x and mx <= tile.x + gameTiles.width and
            my >= tile.y and my <= tile.y + gameTiles.height
    end
end

function gameTiles.mousepressed(x, y, button)
    if button == 1 then 
        for _, tile in ipairs(gameTiles.gameButtons) do
            if tile.hovered then
                tile.clicked = true
            else
                tile.clicked = false
            end
        end
    end
end




return gameTiles
