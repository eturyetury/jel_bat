local shield = {}

lg = love.graphics
local anim8 = require("Libraries/anim8")

local shieldSpriteDone = false
local shieldDone = false

function love.load()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(1140, 600)
    sw, sh = love.graphics.getDimensions()

    shieldSprite = {}
        shieldSprite.spritesheet = lg.newImage("Sprites/cultist-shield.png")
        shieldSprite.spritesheet:setFilter("nearest", "nearest")
        shieldSprite.grid = anim8.newGrid(60, 72, shieldSprite.spritesheet:getWidth(), shieldSprite.spritesheet:getHeight())
        shieldSprite.playSpeed = 0.17
        shieldSprite.dimensionX, shieldSprite.dimensionY = shieldSprite.spritesheet:getDimensions()
        shieldSprite.scale = 3
        shieldSprite.x = nil
        shieldSprite.y = nil
        shieldSprite.animation = anim8.newAnimation(shieldSprite.grid('1-5', 1), shieldSprite.playSpeed, 'pauseAtEnd') 
end

function love.update(dt)
    if not shieldSpriteDone then
        shieldSprite.animation:update(dt)
        if shieldSprite.animation.status == "paused" then
            shieldSpriteDone = true
        end
    end
end

function love.draw()
    if not shieldDone then
        shieldSprite.animation:draw(shieldSprite.spritesheet, sw / 2, sh / 2, 0, shieldSprite.scale, shieldSprite.scale)
    end
end

return shield