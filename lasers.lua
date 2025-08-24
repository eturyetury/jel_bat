local gameState  = require("gameState")
local timer      = require("timer")
local items      = require("items")
local gameTiles  = require("tiles")

lasers = {}

local anim8 = require("Libraries/anim8")
lg = love.graphics

local laserActiv      =  false
local startAnimDone  =  false
local idleAnimStart  =  false
local idleAnimDone   =  false
local animDone       =  false
local laserTimer     =  0



function lasers.load()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(1140, 600)
    sw, sh = love.graphics.getDimensions()
   
    -- LEFT LASER
    laserLeft = {}
        laserLeft.spritesheet = lg.newImage("Sprites/Lazers/Laser_Beam_Spritesheet_INVERTED_WHITE.png")
        laserLeft.spritesheet:setFilter("nearest", "nearest")
        laserLeft.grid = anim8.newGrid( 48, 48, laserLeft.spritesheet:getWidth(), laserLeft.spritesheet:getHeight() )
        laserLeft.playSpeed = 0.05
        laserLeft.dimensionsX, laserLeft.dimensionsY = laserLeft.spritesheet:getDimensions()
        laserLeft.scale = 3
        laserLeft.startOffset = 96
        laserLeft.bodyOffset = 144
        laserLeft.tooManyOffsets = 48
        laserLeft.x = nil
        laserLeft.y = nil

    laserLeft.animations = {}
        laserLeft.animations.startHandle  =  anim8.newAnimation( laserLeft.grid('1-4', 6), laserLeft.playSpeed)
        laserLeft.animations.startBody    =  anim8.newAnimation( laserLeft.grid('1-4', 4), laserLeft.playSpeed)
        laserLeft.animations.startTip     =  anim8.newAnimation( laserLeft.grid('1-4', 2), laserLeft.playSpeed)
        laserLeft.animations.idleHandle   =  anim8.newAnimation( laserLeft.grid('1-4', 5), laserLeft.playSpeed)
        laserLeft.animations.idleBody     =  anim8.newAnimation( laserLeft.grid('1-4', 3), laserLeft.playSpeed)
        laserLeft.animations.idleTip      =  anim8.newAnimation( laserLeft.grid('1-4', 1), laserLeft.playSpeed)
        laserLeft.animations.endHandle    =  anim8.newAnimation( laserLeft.grid('4-1', 6), laserLeft.playSpeed)
        laserLeft.animations.endBody      =  anim8.newAnimation( laserLeft.grid('4-1', 4), laserLeft.playSpeed)
        laserLeft.animations.endTip       =  anim8.newAnimation( laserLeft.grid('4-1', 2), laserLeft.playSpeed)

    -- RIGHT LASER
    laserRight = {}
        laserRight.spritesheet = lg.newImage("Sprites/Lazers/Laser_Beam_Spritesheet_INVERTED_WHITE.png")
        laserRight.spritesheet:setFilter("nearest", "nearest")
        laserRight.grid = anim8.newGrid( 48, 48, laserRight.spritesheet:getWidth(), laserRight.spritesheet:getHeight() )
        laserRight.playSpeed = 0.05
        laserRight.dimensionsX, laserRight.dimensionsY = laserRight.spritesheet:getDimensions()
        laserRight.scale = 3
        laserRight.startOffset = 96
        laserRight.bodyOffset = 144
        laserRight.tooManyOffsets = 48
        laserRight.x = nil
        laserRight.y = nil

    laserRight.animations = {}
        laserRight.animations.startHandle  =  anim8.newAnimation( laserRight.grid('1-4', 6), laserRight.playSpeed)
        laserRight.animations.startBody    =  anim8.newAnimation( laserRight.grid('1-4', 4), laserRight.playSpeed)
        laserRight.animations.startTip     =  anim8.newAnimation( laserRight.grid('1-4', 2), laserRight.playSpeed)
        laserRight.animations.idleHandle   =  anim8.newAnimation( laserRight.grid('1-4', 5), laserRight.playSpeed)
        laserRight.animations.idleBody     =  anim8.newAnimation( laserRight.grid('1-4', 3), laserRight.playSpeed)
        laserRight.animations.idleTip      =  anim8.newAnimation( laserRight.grid('1-4', 1), laserRight.playSpeed)
        laserRight.animations.endHandle    =  anim8.newAnimation( laserRight.grid('4-1', 6), laserRight.playSpeed)
        laserRight.animations.endBody      =  anim8.newAnimation( laserRight.grid('4-1', 4), laserRight.playSpeed)
        laserRight.animations.endTip       =  anim8.newAnimation( laserRight.grid('4-1', 2), laserRight.playSpeed)

    -- UP LASER
    laserUp = {}
        laserUp.spritesheet = lg.newImage("Sprites/Lazers/Laser_Beam_Spritesheet_INVERTED_WHITE.png")
        laserUp.spritesheet:setFilter("nearest", "nearest")
        laserUp.grid = anim8.newGrid( 48, 48, laserUp.spritesheet:getWidth(), laserUp.spritesheet:getHeight() )
        laserUp.playSpeed  = 0.05
        laserUp.dimensionsX, laserUp.dimensionsY = laserUp.spritesheet:getDimensions()
        laserUp.scale = 3
        laserUp.startOffset = 96
        laserUp.bodyOffset = 144
        laserUp.tooManyOffsets = 48
        laserUp.x = nil
        laserUp.y = nil

    laserUp.animations = {}
        laserUp.animations.startHandle  =  anim8.newAnimation( laserUp.grid('1-4', 6), laserUp.playSpeed )
        laserUp.animations.startBody    =  anim8.newAnimation( laserUp.grid('1-4', 4), laserUp.playSpeed )
        laserUp.animations.startTip     =  anim8.newAnimation( laserUp.grid('1-4', 2), laserUp.playSpeed )
        laserUp.animations.idleHandle   =  anim8.newAnimation( laserUp.grid('1-4', 5), laserUp.playSpeed )
        laserUp.animations.idleBody     =  anim8.newAnimation( laserUp.grid('1-4', 3), laserUp.playSpeed )
        laserUp.animations.idleTip      =  anim8.newAnimation( laserUp.grid('1-4', 1), laserUp.playSpeed )
        laserUp.animations.endHandle    =  anim8.newAnimation( laserUp.grid('4-1', 6), laserUp.playSpeed )
        laserUp.animations.endBody      =  anim8.newAnimation( laserUp.grid('4-1', 4), laserUp.playSpeed )
        laserUp.animations.endTip       =  anim8.newAnimation( laserUp.grid('4-1', 2), laserUp.playSpeed )

    -- DOWN LASER
    laserDown = {}
        laserDown.spritesheet = lg.newImage("Sprites/Lazers/Laser_Beam_Spritesheet_INVERTED_WHITE.png")
        laserDown.spritesheet:setFilter("nearest", "nearest")
        laserDown.grid = anim8.newGrid( 48, 48, laserDown.spritesheet:getWidth(), laserDown.spritesheet:getHeight() )
        laserDown.playSpeed  = 0.05
        laserDown.dimensionsX, laserDown.dimensionsY = laserDown.spritesheet:getDimensions()
        laserDown.scale = 3
        laserDown.startOffset = 96
        laserDown.bodyOffset = 144
        laserDown.tooManyOffsets = 48
        laserDown.x = sw / 2 + ((48 * laserDown.scale) / 2)
        laserDown.y = sh - laserDown.startOffset

    laserDown.animations = {}
        laserDown.animations.startHandle  =  anim8.newAnimation( laserDown.grid('1-4', 6), laserDown.playSpeed )
        laserDown.animations.startBody    =  anim8.newAnimation( laserDown.grid('1-4', 4), laserDown.playSpeed )
        laserDown.animations.startTip     =  anim8.newAnimation( laserDown.grid('1-4', 2), laserDown.playSpeed )

        laserDown.animations.idleHandle   =  anim8.newAnimation( laserDown.grid('1-4', 5), laserDown.playSpeed )
        laserDown.animations.idleBody     =  anim8.newAnimation( laserDown.grid('1-4', 3), laserDown.playSpeed )
        laserDown.animations.idleTip      =  anim8.newAnimation( laserDown.grid('1-4', 1), laserDown.playSpeed )
        
        laserDown.animations.endHandle    =  anim8.newAnimation( laserDown.grid('4-1', 6), laserDown.playSpeed )
        laserDown.animations.endBody      =  anim8.newAnimation( laserDown.grid('4-1', 4), laserDown.playSpeed )
        laserDown.animations.endTip       =  anim8.newAnimation( laserDown.grid('4-1', 2), laserDown.playSpeed )
end

function lasers.resetLaserAnimation()
    laserActiv = false
    startAnimDone = false
    idleAnimStart = false
    idleAnimDone = false
    animDone = false
    laserTimer = 0
    -- LEFT LASER
        laserLeft.animations.startHandle:gotoFrame(1)
        laserLeft.animations.startBody:gotoFrame(1)
        laserLeft.animations.startTip:gotoFrame(1)
        laserLeft.animations.idleHandle:gotoFrame(1)
        laserLeft.animations.idleBody:gotoFrame(1)
        laserLeft.animations.idleTip:gotoFrame(1)
        laserLeft.animations.endHandle:gotoFrame(1)
        laserLeft.animations.endBody:gotoFrame(1)
        laserLeft.animations.endTip:gotoFrame(1)
    -- RIGHT LASER
        laserRight.animations.startHandle:gotoFrame(1)
        laserRight.animations.startBody:gotoFrame(1)
        laserRight.animations.startTip:gotoFrame(1)
        laserRight.animations.idleHandle:gotoFrame(1)
        laserRight.animations.idleBody:gotoFrame(1)
        laserRight.animations.idleTip:gotoFrame(1)
        laserRight.animations.endHandle:gotoFrame(1)
        laserRight.animations.endBody:gotoFrame(1)
        laserRight.animations.endTip:gotoFrame(1)
    -- UP LASER
        laserUp.animations.startHandle:gotoFrame(1)
        laserUp.animations.startBody:gotoFrame(1)
        laserUp.animations.startTip:gotoFrame(1)
        laserUp.animations.idleHandle:gotoFrame(1)
        laserUp.animations.idleBody:gotoFrame(1)
        laserUp.animations.idleTip:gotoFrame(1)
        laserUp.animations.endHandle:gotoFrame(1)
        laserUp.animations.endBody:gotoFrame(1)
        laserUp.animations.endTip:gotoFrame(1)
    -- DOWN LASER
        laserDown.animations.startHandle:gotoFrame(1)
        laserDown.animations.startBody:gotoFrame(1)
        laserDown.animations.startTip:gotoFrame(1)
        laserDown.animations.idleHandle:gotoFrame(1)
        laserDown.animations.idleBody:gotoFrame(1)
        laserDown.animations.idleTip:gotoFrame(1)
        laserDown.animations.endHandle:gotoFrame(1)
        laserDown.animations.endBody:gotoFrame(1)
        laserDown.animations.endTip:gotoFrame(1)
end

function lasers.update(dt)
        local player = gameState.players[1]
        if player and player.tileIndex then
            local tile = gameTiles.gameButtons[player.tileIndex]
            if tile then
                laserLeft.x = tile.x
                laserLeft.y = tile.y - 47

                laserRight.x = tile.x - 90
                laserRight.y = tile.y - 47

                laserUp.x = tile.x + 99
                laserUp.y = tile.y - 97

                laserDown.x = tile.x - 45
                laserDown.y = tile.y + 150
            end

            local item = items.getItemAtTile(player.tileIndex)
            
            if timer.elapsed == 0 and timer.revolutions > 0 and items.hasTileItem(player.tileIndex) then
            local item = items.getItemAtTile(player.tileIndex)
                if item and item.id == "laser" and not laserActiv then
                    lasers.resetLaserAnimation()
                    laserActiv = true
                    timer.pause()
                end
            end
        end

        if laserActiv then
            laserTimer = laserTimer + dt

            if not startAnimDone then

                -- LEFT anim
                laserLeft.animations.startHandle:update(dt)
                laserLeft.animations.startBody:update(dt)
                laserLeft.animations.startTip:update(dt)

                -- RIGHT anim
                laserRight.animations.startHandle:update(dt)
                laserRight.animations.startBody:update(dt)
                laserRight.animations.startTip:update(dt)

                -- UP anim
                laserUp.animations.startHandle:update(dt)
                laserUp.animations.startBody:update(dt)
                laserUp.animations.startTip:update(dt)
                
                -- DOWN anim
                laserDown.animations.startHandle:update(dt)
                laserDown.animations.startBody:update(dt)
                laserDown.animations.startTip:update(dt)
                
                if laserLeft.animations.startHandle.position == #laserLeft.animations.startHandle.frames then
                    startAnimDone = true
                    idleAnimStart = true
                end
            end
            
            if idleAnimStart and not idleAnimDone then
                -- LEFT anim
                laserLeft.animations.idleHandle:update(dt)
                laserLeft.animations.idleBody:update(dt)
                laserLeft.animations.idleTip:update(dt)
                -- RIGHT anim
                laserRight.animations.idleHandle:update(dt)
                laserRight.animations.idleBody:update(dt)
                laserRight.animations.idleTip:update(dt)

                -- Up anim
                laserUp.animations.idleHandle:update(dt)
                laserUp.animations.idleBody:update(dt)
                laserUp.animations.idleTip:update(dt)
                
                -- DOWN anim
                laserDown.animations.idleHandle:update(dt)
                laserDown.animations.idleBody:update(dt)
                laserDown.animations.idleTip:update(dt)
            
                if laserTimer >= 0.75 then
                    idleAnimDone = true
                end
            end
            
            if idleAnimDone and not animDone then
                -- LEFT
                laserLeft.animations.endHandle:update(dt)
                laserLeft.animations.endBody:update(dt)
                laserLeft.animations.endTip:update(dt)

                -- RIGHT
                laserRight.animations.endHandle:update(dt)
                laserRight.animations.endBody:update(dt)
                laserRight.animations.endTip:update(dt)

                -- UP
                laserUp.animations.endHandle:update(dt)
                laserUp.animations.endBody:update(dt)
                laserUp.animations.endTip:update(dt)
                
                -- DOWN
                laserDown.animations.endHandle:update(dt)
                laserDown.animations.endBody:update(dt)
                laserDown.animations.endTip:update(dt)
                
                if laserLeft.animations.endHandle.position == #laserLeft.animations.endHandle.frames then
                    animDone = true
                    laserActiv = false
                    lasers.resetLaserAnimation()
                    timer.resume()
                end
            end
        end

end

function lasers.isActive()
    return laserActiv
end

function lasers.draw()
    if laserActiv then
        for i = 0, 1 do
            if not startAnimDone then
                -- LEFT LASER
                laserLeft.animations.startHandle:draw(laserLeft.spritesheet, laserLeft.x - laserLeft.startOffset, laserLeft.y, 0 , laserLeft.scale, laserLeft.scale)
                local offset = laserLeft.bodyOffset
                for i = 0, 20 do
                    laserLeft.animations.startBody:draw(laserLeft.spritesheet, laserLeft.x - offset, laserLeft.y, 0, laserLeft.scale, laserLeft.scale)
                    offset = offset + laserLeft.tooManyOffsets
                end
                laserLeft.animations.startTip:draw(laserLeft.spritesheet, laserLeft.x - offset, laserLeft.y, 0, laserLeft.scale, laserLeft.scale)

                -- RIGHT LASER
                laserRight.animations.startHandle:draw(laserRight.spritesheet, laserRight.x + laserRight.startOffset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                offset = laserRight.bodyOffset
                for i = 0, 20 do
                    laserRight.animations.startBody:draw(laserRight.spritesheet, laserRight.x + offset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                    offset = offset + laserRight.tooManyOffsets
                end
                laserRight.animations.startTip:draw(laserRight.spritesheet, laserRight.x + offset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                    
            elseif idleAnimStart and not idleAnimDone then
                -- LEFT LASER
                laserLeft.animations.idleHandle:draw(laserLeft.spritesheet, laserLeft.x - laserLeft.startOffset, laserLeft.y, 0, laserLeft.scale, laserLeft.scale)
                local offset = laserLeft.bodyOffset
                for i = 0, 20 do
                    laserLeft.animations.idleBody:draw(laserLeft.spritesheet, laserLeft.x - offset, laserLeft.y, 0, laserLeft.scale, laserLeft.scale)
                    offset = offset + laserLeft.tooManyOffsets
                end
                laserLeft.animations.idleTip:draw(laserLeft.spritesheet, laserLeft.x - offset, laserLeft.y, 0 , laserLeft.scale, laserLeft.scale)

                -- RIGHT LASER
                laserRight.animations.idleHandle:draw(laserRight.spritesheet, laserRight.x + laserRight.startOffset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                offset = laserRight.bodyOffset
                for i = 0, 20 do
                    laserRight.animations.idleBody:draw(laserRight.spritesheet, laserRight.x + offset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                    offset = offset + laserRight.tooManyOffsets
                end
                laserRight.animations.idleTip:draw(laserRight.spritesheet, laserRight.x + offset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                
            elseif idleAnimDone and not animDone then
                -- LEFT LASER
                laserLeft.animations.endHandle:draw(laserLeft.spritesheet, laserLeft.x - laserLeft.startOffset, laserLeft.y, 0 , laserLeft.scale, laserLeft.scale)
                local offset = laserLeft.bodyOffset
                for i = 0, 20 do
                    laserLeft.animations.endBody:draw(laserLeft.spritesheet, laserLeft.x - offset, laserLeft.y, 0, laserLeft.scale, laserLeft.scale)
                    offset = offset + laserLeft.tooManyOffsets
                end
                laserLeft.animations.endTip:draw(laserLeft.spritesheet, laserLeft.x - offset, laserLeft.y, 0, laserLeft.scale, laserLeft.scale)

                -- RIGHT LASER
                laserRight.animations.endHandle:draw(laserRight.spritesheet, laserRight.x + laserRight.startOffset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                offset = laserRight.bodyOffset
                for i = 0, 20 do
                    laserRight.animations.endBody:draw(laserRight.spritesheet, laserRight.x + offset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)
                    offset = offset + laserRight.tooManyOffsets
                end
                laserRight.animations.endTip:draw(laserRight.spritesheet, laserRight.x + offset + (48 * laserRight.scale), laserRight.y, 0, -laserRight.scale, laserRight.scale)   
            end
            -- DRAW UP
            if not startAnimDone then
                laserUp.animations.startHandle:draw(laserUp.spritesheet, laserUp.x, laserUp.y, 1.5708, laserUp.scale, laserUp.scale)
                local offset = laserUp.tooManyOffsets
                for i = 0, 20 do
                    laserUp.animations.startBody:draw(laserUp.spritesheet, laserUp.x, laserUp.y - offset, 1.5708, laserUp.scale, laserUp.scale)
                    offset = offset + laserUp.tooManyOffsets
                end
                laserUp.animations.startTip:draw(laserUp.spritesheet, laserUp.x, laserUp.y - offset, 1.5708, laserUp.scale, laserUp.scale)
                
            elseif idleAnimStart and not idleAnimDone then
                laserUp.animations.idleHandle:draw(laserUp.spritesheet, laserUp.x, laserUp.y, 1.5708, laserUp.scale, laserUp.scale)
                local offset = laserUp.tooManyOffsets
                for i = 0, 20 do
                    laserUp.animations.idleBody:draw(laserUp.spritesheet, laserUp.x, laserUp.y - offset, 1.5708, laserUp.scale, laserUp.scale)
                    offset = offset + laserUp.tooManyOffsets
                end
                laserUp.animations.idleTip:draw(laserUp.spritesheet, laserUp.x, laserUp.y - offset, 1.5708, laserUp.scale, laserUp.scale)
                
            elseif idleAnimDone and not animDone then
                laserUp.animations.endHandle:draw(laserUp.spritesheet, laserUp.x, laserUp.y, 1.5708, laserUp.scale, laserUp.scale)
                local offset = laserUp.tooManyOffsets
                for i = 0, 20 do
                    laserUp.animations.endBody:draw(laserUp.spritesheet, laserUp.x, laserUp.y - offset, 1.5708, laserUp.scale, laserUp.scale)
                    offset = offset + laserUp.tooManyOffsets
                end
                laserUp.animations.endTip:draw(laserUp.spritesheet, laserUp.x, laserUp.y - offset, 1.5708, laserUp.scale, laserUp.scale)
            end

            -- DRAW DOWN
            if not startAnimDone then
                laserDown.animations.startHandle:draw(laserDown.spritesheet, laserDown.x, laserDown.y, -1.5708, laserDown.scale, laserDown.scale)
                local offset = laserDown.tooManyOffsets
                for i = 0, 20 do
                    laserDown.animations.startBody:draw(laserDown.spritesheet, laserDown.x, laserDown.y + offset, -1.5708, laserDown.scale, laserDown.scale)
                    offset = offset + laserDown.tooManyOffsets
                end
                laserDown.animations.startTip:draw(laserDown.spritesheet, laserDown.x, laserDown.y + offset, -1.5708, laserDown.scale, laserDown.scale)
                
            elseif idleAnimStart and not idleAnimDone then
                laserDown.animations.idleHandle:draw(laserDown.spritesheet, laserDown.x, laserDown.y, -1.5708, laserDown.scale, laserDown.scale)
                local offset = laserDown.tooManyOffsets
                for i = 0, 20 do
                    laserDown.animations.idleBody:draw(laserDown.spritesheet, laserDown.x, laserDown.y + offset, -1.5708, laserDown.scale, laserDown.scale)
                    offset = offset + laserDown.tooManyOffsets
                end
                laserDown.animations.idleTip:draw(laserDown.spritesheet, laserDown.x, laserDown.y + offset, -1.5708, laserDown.scale, laserDown.scale)
                
            elseif idleAnimDone and not animDone then
                laserDown.animations.endHandle:draw(laserDown.spritesheet, laserDown.x, laserDown.y, -1.5708, laserDown.scale, laserDown.scale)
                local offset = laserDown.tooManyOffsets
                for i = 0, 20 do
                    laserDown.animations.endBody:draw(laserDown.spritesheet, laserDown.x, laserDown.y + offset, -1.5708, laserDown.scale, laserDown.scale)
                    offset = offset + laserDown.tooManyOffsets
                end
                laserDown.animations.endTip:draw(laserDown.spritesheet, laserDown.x, laserDown.y + offset, -1.5708, laserDown.scale, laserDown.scale)
            end
        end
    end
end

return lasers