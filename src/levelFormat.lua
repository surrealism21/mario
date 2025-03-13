-- EXAMPLE of the level format.

-- This file serves as a level.



level = {
    -- Tilesets.
    Pa1_tilemap = overworldTilemap,
    Pa2_tilemap = bonusTilemap,
    Pa1_tileTable = createTileTable(overworldTilemap, 1, 9, 8),
    Pa2_tileTable = createTileTable(bonusTilemap, 2, 5, 3),

    -- Metadata.
    name = "Homescreen Level", 
    author = "surrealism",
    version = "1", -- only a string so i don't have to convert it when it renders
    Pa = { 
        { -- Uses Pa1. It's like this so the renderer can be called like this: level.Pa[1]. Also because the user can have unlimited tilesets, so this can't really have a title...
            { -- This is a layer, it's what the renderTable function is called on. 
                squares = {
                    -- FORMAT: 1-2: getTile function, 3: x 4: y 5: width 6: height
                    {1, 1, 0, 15, 30, 2},
                },
                structures = {
                    -- Same as a normal call of the render function but without required tilemap, that is done by weird globals that do weird things
                    {BigHill, 0, 12}, {ThreeBush, 7, 14},
                },
                ninePatches = {
                    -- Same as normal call without tilemap.
                },
            },
        },
    },
}