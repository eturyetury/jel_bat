local players = {}
local gameTiles = require("tiles")
local gameState = require("gameState")
local timer = require("timer")
local items = require("items")
local lasers = require("lasers")

local prevTileIdx = nil

local function getAvailableTiles(currentIndex)
    local available = {}
    local row = math.floor((currentIndex - 1) / 15)
    local col = (currentIndex - 1) % 15
    for r = row - 2, row + 2 do
        for c = col - 2, col + 2 do
            if r >= 0 and r < 10 and c >= 0 and c < 15 then
                local idx = r * 15 + c + 1
                if idx ~= currentIndex then
                    table.insert(available, idx)
                end
            end
        end
    end
    return available
end

function players.mousepressed(x, y)
    local player = gameState.players[1]
    local availableTiles = getAvailableTiles(player.tileIndex)
    for _, idx in ipairs(availableTiles) do
        local tile = gameTiles.gameButtons[idx]
        if tile and
           x >= tile.x and x <= tile.x + gameTiles.width and
           y >= tile.y and y <= tile.y + gameTiles.height then
            selectedTileIndex = idx -- store the selection
            break
        end
    end
end

function players.draw()
    local player1 = gameState.players[1]
    
    -- show available tiles
    local availableTiles = getAvailableTiles(player1.tileIndex)
    for _, idx in ipairs(availableTiles) do
        local tile = gameTiles.gameButtons[idx]
        if tile then
            love.graphics.setColor(0, 1, 0, 0.5) -- green
            love.graphics.setLineWidth(5)
            love.graphics.rectangle("line", tile.x, tile.y, gameTiles.width, gameTiles.height, gameTiles.corner)
        end
    end
    
    -- show selected tile
    if selectedTileIndex then
        local tile = gameTiles.gameButtons[selectedTileIndex]
        if tile then
            love.graphics.setColor(0,0.7,0) -- green
            love.graphics.setLineWidth(3)
            love.graphics.rectangle("fill", tile.x, tile.y, gameTiles.width, gameTiles.height, gameTiles.corner)
        end
    end
    love.graphics.setColor(1,1,1)

    -- draw all players
    local pNames = {"Player", "Aggro", "Def", "Larry"}
    for i, player in ipairs(gameState.players) do
        if player and player.tileIndex then
            local tile = gameTiles.gameButtons[player.tileIndex]
            if tile then
                local centerX = tile.x + gameTiles.width / 2
                local centerY = tile.y + gameTiles.height / 2
                spX, spY = 25 * 0.7, 30 * 0.7
                love.graphics.draw(player.sprite, centerX - spX, centerY - spY, 0 , 0.7, 0.7)

                --love.graphics.print(pNames[i], centerX - 18, centerY - 45)
            end
        end
    end
end

function players.update(dt)
    if timer.elapsed == 0 and timer.revolutions > 0 and not lasers.isActive() then
        if selectedTileIndex then
            local leavingTile = gameState.players[1].tileIndex   -- store starting tile
            gameState.players[1].tileIndex = selectedTileIndex   -- move to new tile
            items.useItem(leavingTile)                           -- mark prev tile as used
            selectedTileIndex = nil
        else
            items.useItem(gameState.players[1].tileIndex)        -- if player doesn't move
        end
    end
end

return players