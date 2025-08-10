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
    "I"  =  invisible
]]

local gameTiles = require("tiles")
local gameState = require("gameState")
local timer = require("timer")
local buttonLoader = require("buttonLoader")

local colors = {
    blue    = {0.2, 0.4, 1, 1},
    green   = {0.2, 0.8, 0.3, 1},
    red     = {1, 0.2, 0.2, 1},
    purple  = {0.6, 0.3, 0.8, 1},
    yellow  = {1, 0.9, 0.1, 1},
    blank   = {1, 1, 1, 1}
}

local items = {
    -- WEAPONS
    {
        id = "laser",
        damage = 30,
        rarity = 1/20,
        color = colors.blue
    },
    -- HEALTH
    {
        id = "healing",
        health = 30,
        rarity = 1/14,
        color = colors.green
    },
    -- BUFFS
    {
        id = "shield",
        rarity = 1/13,
        color = colors.yellow
    },
    -- UTILITIES
    {
        id = "teleport",
        rarity = 1/18,
        color = colors.purple
    },
    -- TRAPS
    {
        id = "mine",
        rarity = 1/3,
        color = colors.red
    },
    
    -- BLANK
    {
        id = "",
        rarity = 1/3,
        color = colors.blank
    }
}

items.storage = {
    loader  =  {},
    row1    =  {},
    row2    =  {},
    row3    =  {},
    row4    =  {},
    row5    =  {}
}

local function setColorOrDefault(c)
    c = c or colors.blank
    love.graphics.setColor(c[1], c[2], c[3], c[4] or 1)
end

function items.chooseItem() -- weighted, random item selector
    local totalWeight = 0
    for _, item in ipairs(items) do
        totalWeight = totalWeight + item.rarity         -- calc sum of all rarity values
    end
    local randomItem = math.random() * totalWeight      -- generate random number (0-1)
    local cumulative = 0
    for _, item in ipairs(items) do
        cumulative = cumulative + item.rarity           
        if randomItem <= cumulative then                -- determine item
            return item
        end
    end
end

function items.makeRow(count) -- creates 1 row of 15 items
    count = count or 15
    local row = {}
    for i = 1, count do
        row[i] = items.chooseItem()
    end
    return row
end

items.usedTiles = {} -- tracks tiles used by players

function items.initRows() -- progressively initializes rows

    -- fill loader, row1, row2 at startup
    items.storage.loader = items.makeRow(15)
    items.storage.row1 = items.makeRow(15)
    items.storage.row2 = items.makeRow(15)

    items.storage.row3 = {}
    items.storage.row4 = {}
    items.storage.row5 = {}
    
    for i = 1, 75 do -- initializes used tiles tracker
        items.usedTiles[i] = false
    end
end

items.initRows()

function items.advanceRows() -- row move down
    
    local s = items.storage

    s.row5 = nil                   -- delete bottom row

    s.row5 = s.row4                -- shift rows
    s.row4 = s.row3
    s.row3 = s.row2
    s.row2 = s.row1

    s.row1 = s.loader              -- loader to row1

    s.loader = items.makeRow(15)   -- new row generation/insert into loader
    
    -- CREATE USED TILE TABLE
    local newUsedTiles = {}        

    for i = 1, 75 do                     
        newUsedTiles[i] = false    -- inits all as false     
    end

    for i = 1, 60 do               -- shift used tile rows 1 through 4 
        newUsedTiles[i + 15] = items.usedTiles[i]
    end

    items.usedTiles = newUsedTiles
end

function items.useItem(tileIndex)
    if tileIndex >= 1 and tileIndex <= 75 then
        items.usedTiles[tileIndex] = true   -- setting as used
    end
end

function items.drawLoader()                 -- draws items in the loader bar
    local row = items.storage.loader
    local buttons = buttonLoader.buttons        
    
    for i, item in ipairs(row) do
        local item = row[i]                 -- get item from current row
        local button = buttons[i]           -- retrieve loader GUI positions
        setColorOrDefault(item.color)
        love.graphics.print(item.id, button.x + 6, button.y + 4)
    end
    love.graphics.setColor(1,1,1,1)
end

function items.drawGrid()
    local rows = {"row1","row2","row3","row4","row5"}
    local tiles = gameTiles.gameButtons
    local ti = 1

    for _, rowName in ipairs(rows) do
        local row = items.storage[rowName]
        for i = 1, 15 do
            local item = row and row[i]
            local tile = tiles[ti]          -- retrieve tile GUI positions
            
            if item and not items.usedTiles[ti] then
                setColorOrDefault(item.color)
                love.graphics.print(item.id, tile.x + 6, tile.y + 4)
            end
            ti = ti + 1                     -- go to next tile index (1-75)
        end
    end
    love.graphics.setColor(1,1,1,1)
end

function items.getItemAtTile(tileIndex)  -- get item at specific tile index

    if tileIndex < 1 or tileIndex > 75 then
        return nil
    end
    
    local rowIndex = math.floor((tileIndex - 1) / 15) + 1       -- calculate row number
    local colIndex = ((tileIndex - 1) % 15) + 1                 -- calculate column number
    
    local rowNames = {"row1", "row2", "row3", "row4", "row5"}
    local rowName = rowNames[rowIndex]                          -- map row index to string in rowNames
    
    if items.storage[rowName] and items.storage[rowName][colIndex] then     -- check row exists/item present
        return items.storage[rowName][colIndex]
    end
    
    return nil
end

function items.hasTileItem(tileIndex) -- check if tile has active item
    return items.getItemAtTile(tileIndex) ~= nil and not items.usedTiles[tileIndex]
end

return items