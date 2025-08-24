local mine = {}



lg = love.graphics
local anim8 = require("Libraries/anim8")

local mineSpriteDone = false

function love.load()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(1140, 600)
    sw, sh = love.graphics.getDimensions()    

    mineSprite = {}
        mineSprite.spritesheet = lg.newImage("Sprites/mine/mine-spritesheet.png")
        mineSprite.spritesheet:setFilter("nearest", "nearest")
        mineSprite.grid = anim8.newGrid( 48, 48, mineSprite.spritesheet:getWidth(), mineSprite.spritesheet:getHeight() )
        mineSprite.playSpeed = 0.05
        mineSprite.dimensionX, mineSprite.dimensionY = mineSprite.spritesheet:getDimensions()
        mineSprite.scale = 3
        mineSprite.x = nil
        mineSprite.y = nil
        mineSprite.animation = anim8.newAnimation(mineSprite.grid('1-10', 1), mineSprite.playSpeed)  
end

function love.update(dt)
    if not mineSpriteDone then
        mineSprite.animation:update(dt)
    end
    if mineSprite.animation.position == #mineSprite.animation.frames then
        mineSpriteDone = true
    end
end

function love.draw()
    if not mineSpriteDone then
        mineSprite.animation:draw(mineSprite.spritesheet, sw / 2, sh / 2, 0, mineSprite.scale, mineSprite.scale)
    end
end


return mine