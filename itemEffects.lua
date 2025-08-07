local items = require("items")
local players = require("players")
local tiles = require("tiles")
local gameState = require("gameState")
local timer = require("timer")

lg = love.graphics

local itemEffects = {}

local laserActive = false
local laserTimer = 0
local LASER_DURATION = 2.0

function itemEffects.draw()
    if laserActive then
        lg.setColor(0.2, 0.8, 1, 0.9)
        lg.rectangle("fill", 0, love.graphics.getHeight() / 2 - 15, love.graphics.getWidth(), 30)
        lg.setColor(1, 1, 1, 1)
    end
end

function itemEffects.update(dt)
    if laserActive then
        laserTimer = laserTimer + dt
        if laserTimer >= LASER_DURATION then
            laserActive = false
            laserTimer = 0
        end
    end
    
    local player = gameState.players[1]
    if player and player.tileIndex then
        local item = items.getItemAtTile(player.tileIndex)
        
        if timer.elapsed == 0 and timer.revolutions > 0 and item and item.id == "laser" and not laserActive then
            
            laserActive = true
            laserTimer = 0
        end
    end
end

return itemEffects