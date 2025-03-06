require("lib")

-- Texture atlases in the game, a System of great epics

-- TODO: functions to get the image data 😭 I need to sleep so for now i'll just do pallets

-- guide to P numbers.
-- A p is a palette. It has tiles
-- Palette 0: dirt, blocks, bricks, bill blasters, pulleys, "Shroom Stem"
-- Palette 1: decals and pipes
-- Palette 2: Water, clouds, cloud block, Bowser bridge block
-- Palette 3: ? block, coins, bridge axe
-- However, there exists a PALETTE SHROOM. This palette is totally epic and used by the mushrooms, even though it's *technically* in palette 0.
-- The original game has weird shit for that mushroom thing.

black = { 0, 0, 0 }
white = { 1, 1, 1 }

-- standard overworld.
overworld = {
    P0 = {
        _1 = { cRGB(255, 206, 197) },
        _2 = { cRGB(156, 74, 0) },
        _3 = black,
    },
    P1 = {
        _1 = { cRGB(140, 214, 0) },
        _2 = { cRGB(16, 148, 0) },
        _3 = black,
    },
    P2 = {
        _1 = white,
        _2 = { cRGB(99, 173, 255) },
        _3 = black,
    },
}
-- mushroom colors - for Palette 1 tiles, but had to put this in it's own array. It doesn't have any for Palette 0.
shroom = {
    _1 = { cRGB(230, 156, 33) },
    _2 = { cRGB(181, 49, 33) },
    _3 = black,
}