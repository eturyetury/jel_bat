local anim8 = require("Libraries/anim8")
lg = love.graphics
startAnimDone  =  false
idleAnimStart  =  false
idleAnimDone   =  false
animDone       = false
local timer = 0

function love.load()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(1140, 600)
    sw, sh = love.graphics.getDimensions()
   
    laser = {}
    laser.spritesheet = lg.newImage("Sprites/Lazers/Laser_Beam_Spritesheet_INVERTED_WHITE.png")
    laser.spritesheet:setFilter("nearest", "nearest")
    laser.grid = anim8.newGrid( 48, 48, laser.spritesheet:getWidth(), laser.spritesheet:getHeight() )
    laser.playSpeed = 0.05
    laser.dimensionsX, laser.dimensionsY = laser.spritesheet:getDimensions()
    laser.scale = 3
    laser.startOffset = 96
    laser.bodyOffset = 144
    laser.tooManyOffsets = 48
    laser.x = sw
    laser.y = (sh / 2) - ((48 * laser.scale) / 2)

    laser.animations = {}
    laser.animations.startHandle  =  anim8.newAnimation( laser.grid('1-4', 6), laser.playSpeed)
    laser.animations.startBody    =  anim8.newAnimation( laser.grid('1-4', 4), laser.playSpeed)
    laser.animations.startTip     =  anim8.newAnimation( laser.grid('1-4', 2), laser.playSpeed)
    laser.animations.idleHandle   =  anim8.newAnimation( laser.grid('1-4', 5), laser.playSpeed)
    laser.animations.idleBody     =  anim8.newAnimation( laser.grid('1-4', 3), laser.playSpeed)
    laser.animations.idleTip      =  anim8.newAnimation( laser.grid('1-4', 1), laser.playSpeed)
    laser.animations.endHandle    =  anim8.newAnimation( laser.grid('4-1', 6), laser.playSpeed)
    laser.animations.endBody      =  anim8.newAnimation( laser.grid('4-1', 4), laser.playSpeed)
    laser.animations.endTip       =  anim8.newAnimation( laser.grid('4-1', 2), laser.playSpeed)
end

function love.update(dt)
    timer = timer + dt
    

    if not startAnimDone then
        laser.animations.startHandle:update(dt)
        laser.animations.startBody:update(dt)
        laser.animations.startTip:update(dt)
        
        if laser.animations.startHandle.position == #laser.animations.startHandle.frames then
            startAnimDone = true
            idleAnimStart = true
        end
    end
    
    if idleAnimStart and not idleAnimDone then
        laser.animations.idleHandle:update(dt)
        laser.animations.idleBody:update(dt)
        laser.animations.idleTip:update(dt)
       
        if timer >= 0.75 then
            idleAnimDone = true
        end
    end
    
    if idleAnimDone and not animDone then
        laser.animations.endHandle:update(dt)
        laser.animations.endBody:update(dt)
        laser.animations.endTip:update(dt)
        
        if laser.animations.endHandle.position == #laser.animations.endHandle.frames then
            animDone = true
        end
    end
end

function love.draw()
    for i = 0, 9 do
        if not startAnimDone then
            laser.animations.startHandle:draw(laser.spritesheet, laser.x - laser.startOffset, laser.y, 0 , laser.scale, laser.scale)
            local offset = laser.bodyOffset
            for i = 0, 20 do
                laser.animations.startBody:draw(laser.spritesheet, laser.x - offset, laser.y, 0, laser.scale, laser.scale)
                offset = offset + laser.tooManyOffsets
            end
            laser.animations.startTip:draw(laser.spritesheet, laser.x - offset, laser.y, 0, laser.scale, laser.scale)
            
        elseif idleAnimStart and not idleAnimDone then
            laser.animations.idleHandle:draw(laser.spritesheet, laser.x - laser.startOffset, laser.y, 0, laser.scale, laser.scale)
            local offset = laser.bodyOffset
            for i = 0, 20 do
                laser.animations.idleBody:draw(laser.spritesheet, laser.x - offset, laser.y, 0, laser.scale, laser.scale)
                offset = offset + laser.tooManyOffsets
            end
            laser.animations.idleTip:draw(laser.spritesheet, laser.x - offset, laser.y, 0 , laser.scale, laser.scale)
            
        elseif idleAnimDone and not animDone then
            laser.animations.endHandle:draw(laser.spritesheet, laser.x - laser.startOffset, laser.y, 0 , laser.scale, laser.scale)
            local offset = laser.bodyOffset
            for i = 0, 20 do
                laser.animations.endBody:draw(laser.spritesheet, laser.x - offset, laser.y, 0, laser.scale, laser.scale)
                offset = offset + laser.tooManyOffsets
            end
            laser.animations.endTip:draw(laser.spritesheet, laser.x - offset, laser.y, 0, laser.scale, laser.scale)
        end
    end
end