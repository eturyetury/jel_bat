--[[
    "B"  =  bomb
    "AS" =  airstrike
    "L"  =  laser
    "M"  =  mine
    "S"  =  shield
    "F"  =  freeze
    "T"  =  teleport
    "H"  =  health
    "EJ" =  extra jump
    "HB" =  handbag
]]

local gameTiles = require("tiles")
local gameState = require("gameState")
local players = require("players")
local timer = require("timer")
local buttonLoader = require("buttonLoader")

local colors = {
    blue    = {0.2, 0.4, 1, 1},
    green   = {0.2, 0.8, 0.3, 1},
    red     = {1, 0.2, 0.2, 1},
    purple  = {0.6, 0.3, 0.8, 1},
    yellow  = {1, 0.9, 0.1, 1}
}

items = {
    --[[WEAPONS]]
    {
        id = "laser",
        damage = 30,
        rarity = 1/15,
        color = colors.blue
    },
    --[[HEALTH]]
    {
        id = "healing",
        health = 30,
        rarity = 1/14
        color = colors.green
    },
    --[[BUFFS]]
    {
        id = "shield",
        rarity = 1/7,
        color = colors.yellow
    },
    --[[UTILITIES]]
    {
        id = "teleport",
        rarity = 1/9,
        color = colors.purple
    },
    --[[TRAPS]]
    {
        id = "mine",
        rarity = 1/5,
        color = colors.red
    },
    --[[EMPTY]]
    {
        id = "",
        rarity = 1/3
    }
}

numberOfItems = 

items.storage = {
    loader  =  {},
    row1    =  {},
    row2    =  {},
    row3    =  {},
    row4    =  {},
    row5    =  {}
}


function items.chooseItem()
    local totalWeight = 0
    for _, item in ipairs(items) do
        totalWeight = totalWeight + item.rarity
    end

    local randomItem = math.random() * totalWeight

    local cumulative = 0
    for _, item in ipairs(items) do
        cumulative = cumulative + item.rarity
        if randomItem <= cumulative then
            return item
        end
    end
end

function items.initRows()
    for _, rows in pairs(items.storage) do
        for i = 0, 14 do
            chosenItem = items.chooseItem()
            table.insert(items.storage[rows], chosenItem)
        end
    end
end

items.initRows()

function items.init()
    

function items.draw()
    local centerX = tile.x + gameTiles.width / 2
    local centerY = tile.y + gameTiles.height / 2
    for tiles, in ipairs(gameTiles.gameButtons) do
        love.graphics.print()

return items