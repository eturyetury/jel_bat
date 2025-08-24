local gameTiles       = require("tiles")
local buttonLoader    = require("buttonLoader")
local divider         = require("divider")
local dots            = require("dots")
local timer           = require("timer")
local players         = require("players")
local items           = require("items")
local health          = require("health")
local playerAI        = require("playerAI")
--local itemEffects     = require("itemEffects")

local lasers          = require("lasers")

lg = love.graphics

function love.load()
    math.randomseed(os.time())
    math.random(); math.random(); math.random()
    items.initRows()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(2280, 1200)
    sw, sh = love.graphics.getDimensions()
    lasers.load()
    love.window.setFullscreen(false, "desktop")
end

function love.draw()
    lg.setColor(1,1,1)
--[[
    local rectW = 982.9147
    local rectH = 442.466
    local rectX = sw / 2 - (rectW / 2)
    local rectY = sh / 2 - rectH / 2 - 78.767 / 2
    lg.rectangle("line", rectX, rectY, rectW, rectH)
]]
    lg.setLineWidth(2)
    gameTiles.draw()
    lg.setLineWidth(2)
    buttonLoader.draw()
    lg.setLineWidth(1)
    dots.draw()
    timer.draw()
    players.draw()
    health.draw()
    health.icons()
    items.drawGrid()
    items.drawLoader()
    --itemEffects.draw()
    lasers.draw()
end

function love.update(dt)
    timer.update(dt)
    gameTiles.update(dt)
    players.update(dt)

    if timer.elapsed == 0 and not timer.paused then
        items.advanceRows()
    end
    lasers.update(dt)
end

function love.mousepressed(x, y, button)
    gameTiles.mousepressed(x, y, button)
    players.mousepressed(x, y)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end
end
