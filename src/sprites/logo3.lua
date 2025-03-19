require("spriteSystem")
require("atlas")

sprites.Logo3.prepare = function()
    sprites.Logo3.logo3Tilemap = love.graphics.newImage("assets/atlas/logo3.png")
    sprites.Logo3.tileTable = createTileTable(sprites.Logo3.logo3Tilemap, 1, 4, 2, 42, 48)
end

sprites.Logo3.run = function()

end