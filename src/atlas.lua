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
    local width = ((image:getWidth() - 1) / 17) - 1 -- the -1 is due to an unexplainable bug i cannot explain. It's kind of a hack. I COULD probably figure it out, but it's Friday and I want to watch YouTube.
    local height = ((image:getHeight() - 1) / 17) - 1
    local tileName = nil -- nils will be set later in the loop
    local xPos = nil
    local yPos = nil
    table.insert(tableTile.metadata, width) -- tiles wide
    table.insert(tableTile.metadata, height) -- tiles high
    table.insert(tableTile.metadata, width*height) -- total number of tiles
    table.insert(tableTile.metadata, image) -- image the tiles use

    for yTile = 0, height do 
        for xTile = 0, width do
            tileName = xTile .. "," .. yTile -- add em' up
            -- Ok now we get the pos
            xPos = (xTile * 16) + (xTile+1)
            yPos = (yTile * 16) + (yTile+1)
            -- Ok now we insert in TABLE's tile section
            table.insert(tableTile.tiles, love.graphics.newQuad(xPos, yPos, 16, 16, image))
        end
    end
    return tableTile
end

-- gets a tile from a tilemap, for drawing or something. EX to get 1,1 tile in the "overworld" set, I would use overworld.tiles[getTile(overworld, 1, 1)] to get the tile's number.
-- Maths: 1st step. Get the tiles poses and make them a single number. 2nd step. Add a offset - the amount away from the edge of the tilemap -1 because lua starts at 1 🙃
function getTile(TileTable, tileX, tileY) return (tileX*tileY) + (((TileTable.metadata[1] + 1) - tileX) * (tileY - 1)) end -- again adding 1 to the metadata is because of stupid hack

function getTileCoordPair(TileTable, tilePos) return (tilePos[1]*tilePos[2]) + (((TileTable.metadata[1] +1) - tilePos[1]) * (tilePos[2] -1)) end -- Same thing as last one but for a coordinate pair array.

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

function drawAssembledStructure(aStruct, baseTiles, x, y)
    local uhm = {}
    for current_row = 1, aStruct.metadata.rows do
        for current_column = 1, aStruct.metadata.columns do
            uhm = aStruct[current_row]
            if uhm[current_column] ~= nil then
                love.graphics.draw(baseTiles.metadata[4], baseTiles.tiles[getTileCoordPair(baseTiles, uhm[current_column])], (x*16)+((current_column-1)*16), (y*16)+((current_row-1)*16))
            end
        end
    end
end

-- Actual assembled structure arrays
-- these are the built in ones, not the txt files users can provide... do not change!

-- Rows are X rows. x1, x2 etc... these are the tiles themselves. If a "x" is nil, do not draw a tile. DO NOT use a blank tile for a nil space.

-- Metadata (you must set "tilemap" and "rows")...
-- These should be obvious, but more may be added eventually
Bush = {
    metadata = {
        rows = 1,
        columns = 3,
    },
    {{1, 6}, {2, 6}, {3, 6}},
}

TwoBush = {
    metadata = {
        rows = 1,
        columns = 4,
    },
    {{1, 6}, {2, 6}, {2, 6}, {3, 6}},
}

ThreeBush = {
    metadata = {
        rows = 1,
        columns = 5,
    },
    {{1, 6}, {2, 6}, {2, 6}, {2, 6}, {3, 6}},
}

BigHill = {
    metadata = {
        rows = 3,
        columns = 5,
    },
    {nil, nil, {3, 7}, nil, nil},
    {nil, {1, 8}, {2, 8}, {5, 8}, nil},
    {{1,8}, {2, 8}, {3, 8}, {2, 8}, {5, 8}},
}
