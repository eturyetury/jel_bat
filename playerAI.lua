local timer = require("timer")
local gameTiles = require("tiles")
local gameState = require("gameState")
local players = require("players")
local playerAI = {}
local AIpersonas = {
    aggro = {
        name = "aggro",
        itemBias = {
            laser = 10,
            mine = 5,
            shield = 3,
            healing = 4,
            teleport = 4,
            [""] = -5,
        },
        riskTolerance = 0.8,
        planningDepth = 2,
    },
    tank = {
        name = "tank",
        itemBias = {
            laser = 3,
            mine = 1,
            shield = 10,
            healing = 9,
            teleport = 7,
            [""] = 2,
        },
        riskTolerance = 0.2,
        planningDepth = 3,
    },
    larry = {
        name = "larry",
        itemBias = {
            laser = 6,
            mine = 5,
            shield = 6,
            healing = 5,
            teleport = 8,
            [""] = 0,
        },
        riskTolerance = 0.5,
        planningDepth = 2,
    }
}

local function initAI()
    local persona = { "aggro", "tank", "larry" }
    local personaIndex = 1
    for i = 2, 4 do
        gameState.players[i].persona = AIpersonas[persona[personaIndex]]
        gameState.players[i].lastMoveTime = 0
        gameState.players[i].selectedTile = nil
        personaIndex = personaIndex + 1

    end
end

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

function playerAI.draw()
    for i = 2, math.min(4, #gameState.players) do
        local player = gameState.players[i]
        local tileIndex = player.selectedTile or player.tileIndex
        local tile = gameTiles.gameButtons[tileIndex]
        if tile then
            local centerX = tile.x + gameTiles.width / 2
            local centerY = tile.y + gameTiles.height / 2
            love.graphics.setColor(player.color)
            love.graphics.circle("fill", centerX, centerY, 10)
        end
    end
end

local function moveAI()
    return nil
end

playerAI.initAI = initAI

return playerAI