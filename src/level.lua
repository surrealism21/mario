-- Hardcoded first level, created so if I could create the rest
-- This is also the level format
titlescreen = {
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
}

ninePatchTableTest = {
    squares = {

    },
    structures = {

    },
    ninePatches = {
        {bonus9Patch, 1, 2, 4, 4},
    },
}