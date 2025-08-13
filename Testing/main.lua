local anim8 = require("Libraries/anim8")
lg = love.graphics
startAnimDone  =  false
idleAnimStart  =  false
idleAnimDone   =  false
animDone       =  false
local timer = 0

function love.load()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(1140, 600)
    sw, sh = love.graphics.getDimensions()
    
    --UP LASER
    laserUp = {}
        laserUp.spritesheet = lg.newImage("Sprites/Lazers/laser_Beam_Spritesheet_INVERTED_WHITE.png")
        laserUp.spritesheet:setFilter("nearest", "nearest")
        laserUp.grid = anim8.newGrid( 48, 48, laserUp.spritesheet:getWidth(), laserUp.spritesheet:getHeight() )
        laserUp.playSpeed  = 0.05
        laserUp.dimensionsX, laserUp.dimensionsY = laserUp.spritesheet:getDimensions()
        laserUp.scale = 3
        laserUp.startOffset = 96
        laserUp.bodyOffset = 144
        laserUp.tooManyOffsets = 48
        laserUp.x = sw / 2 + ((48 * laserUp.scale) / 2)
        laserUp.y = sh - laserUp.startOffset

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

    --DOWN LASER
    laserDown = {}
        laserDown.spritesheet = lg.newImage("Sprites/Lazers/laser_Beam_Spritesheet_INVERTED_WHITE.png")
        laserDown.spritesheet:setFilter("nearest", "nearest")
        laserDown.grid = anim8.newGrid( 48, 48, laserDown.spritesheet:getWidth(), laserDown.spritesheet:getHeight() )
        laserDown.playSpeed  = 0.05
        laserDown.dimensionsX, laserDown.dimensionsY = laserDown.spritesheet:getDimensions()
        laserDown.scale = 3
        laserDown.startOffset = 96
        laserDown.bodyOffset = 144
        laserDown.tooManyOffsets = 48
        laserDown.x = sw / 2 - ((48 * laserDown.scale) / 2) -- Positioned to the left of the up laser
        laserDown.y = laserDown.startOffset -- Starting from the top

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

function love.update(dt)
    timer = timer + dt
    
    if not startAnimDone then
        -- Update UP laser animations
        laserUp.animations.startHandle:update(dt)
        laserUp.animations.startBody:update(dt)
        laserUp.animations.startTip:update(dt)
        
        -- Update DOWN laser animations
        laserDown.animations.startHandle:update(dt)
        laserDown.animations.startBody:update(dt)
        laserDown.animations.startTip:update(dt)
        
        if laserUp.animations.startHandle.position == #laserUp.animations.startHandle.frames then
            startAnimDone = true
            idleAnimStart = true
        end
    end
    
    if idleAnimStart and not idleAnimDone then
        -- Update UP laser animations
        laserUp.animations.idleHandle:update(dt)
        laserUp.animations.idleBody:update(dt)
        laserUp.animations.idleTip:update(dt)
        
        -- Update DOWN laser animations
        laserDown.animations.idleHandle:update(dt)
        laserDown.animations.idleBody:update(dt)
        laserDown.animations.idleTip:update(dt)
       
        if timer >= 0.75 then
            idleAnimDone = true
        end
    end
    
    if idleAnimDone and not animDone then
        -- Update UP laser animations
        laserUp.animations.endHandle:update(dt)
        laserUp.animations.endBody:update(dt)
        laserUp.animations.endTip:update(dt)
        
        -- Update DOWN laser animations
        laserDown.animations.endHandle:update(dt)
        laserDown.animations.endBody:update(dt)
        laserDown.animations.endTip:update(dt)
        
        if laserUp.animations.endHandle.position == #laserUp.animations.endHandle.frames then
            animDone = true
        end
    end
end

function love.draw()
    -- Draw UP LASER
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

    -- Draw DOWN LASER (flipped to shoot downward)
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