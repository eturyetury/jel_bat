local gameTiles = require("tiles")
local buttonLoader = require("buttonLoader")
local divider = require("divider")
local dots = require("dots")
local timer = require("timer")
local timer2 = require("timer2")
local players = require("players")

lg = love.graphics

function love.load()
    love.graphics.setLineStyle("smooth")
    love.window.setMode(1140, 600)
    sw, sh = love.graphics.getDimensions()
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
    timer2.draw()
    players.draw()


    --[[
    divider.draw()
    ]]
end

function love.update(dt)
    timer.update(dt)
    timer2.update(dt)
    gameTiles.update(dt)
    players.update(dt)
end

function love.mousepressed(x, y, button)
    gameTiles.mousepressed(x, y, button)
    players.mousepressed(x, y)
end
