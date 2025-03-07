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


-- Makes a tile table for a tilemap image. Designed for using any tileset pretty much out of the box. Written from scratch actually
function createTileTable(image)
    local tableTile = {
        metadata = {}, -- Metadata table for height & width information and such
        tiles = {}, -- Tile quads
    }
    local width = image:getWidth() / 18 -- 18 is the width / height of a tile, with any borders.
    local height = image:getHeight() / 18
    local tileName = nil -- nils will be set later in the loop
    local xPos = nil
    local yPos = nil
    table.insert(tableTile.metadata, width) -- tiles wide
    table.insert(tableTile.metadata, height) -- tiles high
    table.insert(tableTile.metadata, width*height) -- total number of tiles

    for yTile = 0, height do 
        for xTile = 0, width do
            tileName = xTile .. "," .. yTile -- add em' up
            -- Ok now we get the pos
            xPos = (xTile * 16) + (xTile+1) -- Adding xTile (and upcoming yTile) accounts for the Epics Offset, created by the borders. Add one to account for the fact it starts at nil
            yPos = (yTile * 16) + (yTile+1)
            -- Ok now we insert in TABLE's tile section
            table.insert(tableTile.tiles, love.graphics.newQuad(xPos, yPos, 16, 16, image))
        end
    end
    return tableTile
end

-- gets a tile from a tilemap, for drawing or something. EX to get 1,1 tile in the "overworld" set, I would use overworld.tiles[getTile(overworld, 1, 1)] to get the tile's number.
-- Maths: 1st step. Get the tiles poses and make them a single number. 2nd step. Add a offset - the amount away from the edge of the tilemap -1 because lua starts at 1 🙃
function getTile(TileTable, tileX, tileY) return (tileX*tileY) + ((TileTable.metadata[1] - tileX) * (tileY - 1)) end

-- Draw a square of tiles with loops
function drawTileSquare(tilemapType, tileQuad, x, y, width, height)
    for current_y = 1, height do
        for current_x = 1, width do
            love.graphics.draw(tilemapType, tileQuad, ((x-1)*16)+(current_x*16), ((y-1)*16)+(current_y*16))
        end
    end
end

-- Assembled structures: these are "prefabs" like the bushes n' shit
-- TODO: make some assembled structures, and a rendering system for them...

function drawAssembledStructure(assembledStructure, x, y)
end
