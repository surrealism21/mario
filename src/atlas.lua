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
overworldTilemap = love.graphics.newImage("assets/atlas/standard-overworld.png")
bonusTilemap = love.graphics.newImage("assets/atlas/bonus.png")

-- Makes a tile table for a tilemap image. Designed for using any tileset pretty much out of the box. Written from scratch actually
function createTileTable(image, spacing, width, height)
    local tableTile = {
        metadata = {}, -- Metadata table for height & width information and such
        tiles = {}, -- Tile quads
    }
    local xPos = nil
    local yPos = nil
    table.insert(tableTile.metadata, width) -- tiles wide
    table.insert(tableTile.metadata, height) -- tiles high
    table.insert(tableTile.metadata, width*height) -- total number of tiles
    table.insert(tableTile.metadata, image) -- image the tiles use

    for yTile = 0, height do 
        for xTile = 0, width do
            -- Ok now we get the pos
            xPos = (xTile * 16) + (xTile*spacing)
            yPos = (yTile * 16) + (yTile*spacing)
            -- Ok now we insert in TABLE's tile section
            table.insert(tableTile.tiles, love.graphics.newQuad(xPos, yPos, 16, 16, image))
        end
    end
    return tableTile
end

-- gets a tile from a tilemap, for drawing or something. EX to get 1,1 tile in the "overworld" set, I would use overworld.tiles[getTile(overworld, 1, 1)] to get the tile's number.
-- Maths: 1st step. Get the tiles poses and make them a single number. 2nd step. Add a offset - the amount away from the edge of the tilemap -1 because lua starts at 1 🙃
function getTile(Pa_tileTable, tileX, tileY) return (Pa_tileTable.metadata[1] * (tileY - 1)) + (tileX + (tileY - 1))  end

function getTileCoordPair(Pa_tileTable, tilePos) return (Pa_tileTable.metadata[1] * (tilePos[2] - 1)) + (tilePos[1] + (tilePos[2] - 1))  end

-- Draw a square of tiles with loops
function drawTileSquare(Pa_tilemap, tileQuad, x, y, width, height)
    for current_y = 1, height do
        for current_x = 1, width do
            love.graphics.draw(Pa_tilemap, tileQuad, ((x-1)*16)+(current_x*16), ((y-1)*16)+(current_y*16))
        end
    end
end

-- Assembled structures: these are "prefabs" like the bushes n' shit
-- TODO: make some assembled structures, and a rendering system for them...

function drawAssembledStructure(Pa_tileTable, aStruct, x, y)
    local uhm = {}
    for current_row = 1, aStruct.metadata.rows do
        for current_column = 1, aStruct.metadata.columns do
            uhm = aStruct[current_row]
            if uhm[current_column] ~= nil then
                love.graphics.draw(Pa_tileTable.metadata[4], Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, uhm[current_column])], (x*16)+((current_column-1)*16), (y*16)+((current_row-1)*16))
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

-- Let's do collider prep now

function prepareLevelCollisionTable(level)
    local collisionTable = {}
    local squares = nil
    -- First we tackle to colliders of tileSquares
    for currentSquare = 1, tablelength(level.squares) do
        square = level.squares[currentSquare]
        -- Adding x, y, width, height to table in a array
        table.insert(collisionTable, {"tile", square[4], square[5], square[6], square[7]})
    end
    return collisionTable
end

function drawTable(Pa_tilemap, Pa_tileTable, level) -- Draws a whole table...
    --First we draw squares!
    for currentSquare = 1, tablelength(level.squares) do
        local square = level.squares[currentSquare]
        drawTileSquare(Pa_tilemap, Pa_tileTable.tiles[getTile(Pa_tileTable, square[1], square[2])], square[3], square[4], square[5], square[6])
    end
    -- now for the prefabs
    if tablelength(level.structures) ~= nil then
        for currentStruct = 1, tablelength(level.structures) do
            structure = level.structures[currentStruct]
            drawAssembledStructure(Pa_tileTable, structure[1], structure[2], structure[3])
        end
    end
    -- 9 patches
    if tablelength(level.ninePatches) ~= nil then
        for currentPatch = 1, tablelength(level.ninePatches) do
            patch = level.ninePatches[currentPatch]
            render9patch(Pa_tilemap, Pa_tileTable, patch[1], patch[2], patch[3], patch[4], patch[5])
        end
    end
end

-- 9 Patch area: 9 patches are tiles that can, uhm, draw. Google it.
-- 9 patches need 9 tiles.

bonus9Patch = {
    {1, 1}, {2, 1}, {3, 1},
    {1, 2}, {2, 2}, {3, 2},
    {1, 3}, {2, 3}, {3, 3},
}

function render9patch(Pa_tilemap, Pa_tileTable, ninePatch, x, y, width, height) -- Last one is a array, in order.
    -- Okay, first corner.
    love.graphics.draw(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[1])], x*16, y*16)
    -- Okay, now we do the width here're
    if width > 2 then
        drawTileSquare(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[2])], x+1, y, width-2, 1)
    end
    -- 3rd thing
    love.graphics.draw(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[3])], (x+width-1)*16, y*16)
    -- I'm left high
    if height > 2 then
        drawTileSquare(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[4])], x, y+1, 1, height-2)
    end
    -- Middle: this will help OK
    if width > 2 and height > 2 then
        drawTileSquare(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[5])], x+1, y+1, width-2, height-2)
    end
    -- Right thing whatever i'm deatg
    if height > 2 then
        drawTileSquare(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[6])], x+width-1, y+1, 1, height-2)
    end
    -- bottom to the Fuckking... left
    love.graphics.draw(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[7])], x*16, ((y-1)*16)+(height*16))
    -- Bot. width
    if width > 2 then
        drawTileSquare(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[8])], x+1, y+height-1, width-2, 1)
    end
    -- this code documentation is so good
    love.graphics.draw(Pa_tilemap, Pa_tileTable.tiles[getTileCoordPair(Pa_tileTable, ninePatch[9])], (x+width-1)*16, ((y-1)*16)+(height*16))
end

