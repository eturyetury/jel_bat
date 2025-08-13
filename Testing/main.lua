-- Simple Rogue-like Dungeon Generator for LÖVE2D
local WALL = 1
local FLOOR = 0
local CORRIDOR = 2

local dungeon = {}
local rooms = {}
local WIDTH = 80
local HEIGHT = 25
local MIN_ROOM_SIZE = 3
local MAX_ROOM_SIZE = 8
local MAX_ROOMS = 12

function love.load()
    love.window.setTitle("Rogue-like Dungeon Generator")
    math.randomseed(os.time())
    generateDungeon()
end

function generateDungeon()
    -- Initialize dungeon with walls
    dungeon = {}
    rooms = {}
    
    for y = 1, HEIGHT do
        dungeon[y] = {}
        for x = 1, WIDTH do
            dungeon[y][x] = WALL
        end
    end
    
    -- Generate rooms
    for i = 1, MAX_ROOMS do
        local w = math.random(MIN_ROOM_SIZE, MAX_ROOM_SIZE)
        local h = math.random(MIN_ROOM_SIZE, MAX_ROOM_SIZE)
        local x = math.random(1, WIDTH - w - 1)
        local y = math.random(1, HEIGHT - h - 1)
        
        local newRoom = {x = x, y = y, w = w, h = h}
        
        -- Check if room overlaps with existing rooms
        local overlaps = false
        for _, room in ipairs(rooms) do
            if roomsOverlap(newRoom, room) then
                overlaps = true
                break
            end
        end
        
        if not overlaps then
            table.insert(rooms, newRoom)
            carveRoom(newRoom)
            
            -- Connect to previous room with corridor
            if #rooms > 1 then
                connectRooms(rooms[#rooms-1], newRoom)
            end
        end
    end
end

function roomsOverlap(room1, room2)
    return not (room1.x + room1.w < room2.x or 
                room2.x + room2.w < room1.x or
                room1.y + room1.h < room2.y or
                room2.y + room2.h < room1.y)
end

function carveRoom(room)
    for y = room.y, room.y + room.h - 1 do
        for x = room.x, room.x + room.w - 1 do
            if x >= 1 and x <= WIDTH and y >= 1 and y <= HEIGHT then
                dungeon[y][x] = FLOOR
            end
        end
    end
end

function connectRooms(room1, room2)
    -- Get center points of rooms
    local x1 = math.floor(room1.x + room1.w / 2)
    local y1 = math.floor(room1.y + room1.h / 2)
    local x2 = math.floor(room2.x + room2.w / 2)
    local y2 = math.floor(room2.y + room2.h / 2)
    
    -- Create L-shaped corridor
    if math.random() < 0.5 then
        -- Horizontal first, then vertical
        carveCorridor(x1, y1, x2, y1) -- horizontal
        carveCorridor(x2, y1, x2, y2) -- vertical
    else
        -- Vertical first, then horizontal
        carveCorridor(x1, y1, x1, y2) -- vertical
        carveCorridor(x1, y2, x2, y2) -- horizontal
    end
end

function carveCorridor(x1, y1, x2, y2)
    local dx = x1 < x2 and 1 or -1
    local dy = y1 < y2 and 1 or -1
    
    if x1 == x2 then
        -- Vertical corridor
        for y = y1, y2, dy do
            if y >= 1 and y <= HEIGHT and x1 >= 1 and x1 <= WIDTH then
                if dungeon[y][x1] == WALL then
                    dungeon[y][x1] = CORRIDOR
                end
            end
        end
    else
        -- Horizontal corridor
        for x = x1, x2, dx do
            if x >= 1 and x <= WIDTH and y1 >= 1 and y1 <= HEIGHT then
                if dungeon[y1][x] == WALL then
                    dungeon[y1][x] = CORRIDOR
                end
            end
        end
    end
end

function love.draw()
    local tileSize = 8
    
    for y = 1, HEIGHT do
        for x = 1, WIDTH do
            local screenX = (x - 1) * tileSize
            local screenY = (y - 1) * tileSize
            
            if dungeon[y][x] == WALL then
                love.graphics.setColor(0.3, 0.3, 0.3) -- Dark gray
            elseif dungeon[y][x] == FLOOR then
                love.graphics.setColor(0.8, 0.8, 0.8) -- Light gray
            else -- CORRIDOR
                love.graphics.setColor(0.6, 0.6, 0.6) -- Medium gray
            end
            
            love.graphics.rectangle("fill", screenX, screenY, tileSize, tileSize)
        end
    end
    
    -- Instructions
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Press SPACE to generate new dungeon", 10, HEIGHT * 8 + 10)
    love.graphics.print("Rooms: " .. #rooms, 10, HEIGHT * 8 + 30)
end

function love.keypressed(key)
    if key == "space" then
        generateDungeon()
    elseif key == "escape" then
        love.event.quit()
    end
end