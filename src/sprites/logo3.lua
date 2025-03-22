require("spriteSystem")
require("atlas")

local currentRect = 1
local timer = 0
sprites.Logo3.prepare = function()
    sprites.Logo3.logo3Tilemap = love.graphics.newImage("assets/atlas/logo3.png")
    sprites.Logo3.tileTable = createTileTable(sprites.Logo3.logo3Tilemap, 1, 4, 2, 42, 48)
end

sprites.Logo3.run = function(x, y)
    dt = love.timer.getDelta()
    timer = timer + 1
    if timer == 10 then
        currentRect = animate(sprites.Logo3.animations.default, sprites.Logo3.tileTable, currentRect)
        timer = 0
    end

    return x, y
end

sprites.Logo3.draw = function(x, y)
    love.graphics.draw(sprites.Logo3.logo3Tilemap, sprites.Logo3.tileTable.tiles[currentRect], x, y)
end
