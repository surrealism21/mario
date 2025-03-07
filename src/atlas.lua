require("lib")

-- Texture atlases in the game, a System of great epics

-- TODO: functions to get the image data 😭 I need to sleep so for now i'll just do pallets

-- guide to P numbers.
-- A p is a palette. It has tiles
-- Palette 0: dirt, blocks, bricks, bill blasters, pulleys, "Shroom Stem"
-- Palette 1: decals and pipes
-- Palette 2: Water, clouds, cloud block, Bowser bridge block
-- Palette 3: ? block, coins, bridge axe, these have 3 frames each and need 9 colors
-- However, there exists a PALETTE SHROOM. This palette is totally epic and used by the mushrooms, even though it's *technically* in palette 0.
-- The original game has weird shit for that mushroom thing.

sky = { cRGB(148,148,255) }
BlockSemiDark = { cRGB(156, 74, 0) }
black = { 0, 0, 0 }
white = { 1, 1, 1 }

-- mushroom colors - for Palette 1 tiles, but had to put this in it's own array. It doesn't have any for Palette 0.
shroom = {
    _1 = { cRGB(230, 156, 33) },
    _2 = { cRGB(181, 49, 33) },
    _3 = black,
}

underground = {
    P0 = { 
        _1 = { cRGB(181, 239, 239) },
        _2 = { cRGB(0, 123, 140) },
        _3 = black,
    },
    P1 = {
        _1 = { cRGB(140, 214, 0) },
        _2 = { cRGB(16, 148, 0) },
        _3 = { cRGB(8, 74, 0) },
    },
    P2 = {
        _1 = white,
        _2 = { cRGB(99, 173, 255) },
        _3 = { cRGB(0, 123, 140) },
    },
    P3 = {
        F1 = {
            _1 = { cRGB(230, 156, 33) },
            _2 = BlockSemiDark,
            _3 = black,
        },
        F2 = {
            _1, _2 = BlockSemiDark, BlockSemiDark,
            _3 = black,
        },
        F3 = {
            _1 = { cRGB(82, 33, 0) },
            _2 = BlockSemiDark,
            _3 = black,
        },
    },
}

-- palette swapper code here... i have to write a shader for this

-- images
love.graphics.setDefaultFilter("nearest", "nearest") -- when you actually LOVE yourself
tilemap = love.graphics.newImage("assets/atlas/standard-overworld.png")

tile = love.graphics.newQuad(1, 1, 16, 16, tilemap)

-- Tiles draw
function drawTileSquare(x, y, width, height)
    for current_y = 1, height do
        for current_x = 1, width do
                love.graphics.draw(tilemap, tile, ((x-1)*16)+(current_x*16), ((y-1)*16)+(current_y*16))
        end
    end
end