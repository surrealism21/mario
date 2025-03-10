require("atlas")
require("level")


-- Home's new screens
cursorSettings = 1
GAME_STATE = "HomeScreen"
function drawHomeScreen()
    -- graphics
    local logo = love.graphics.newImage("assets/logo.png")
    local menus = love.graphics.newImage("assets/menus.png")
    

    love.graphics.setFont(font)

    --Render the homescreen!
    -- tiles decorations
    tileX = 1
    tileY = 1
    --drawTileSquare(CURRENT_tileTable.tiles[getTile(2, 1)], 0, 15, 30, 2)
    --drawAssembledStructure(BigHill, 0, 12)
    --drawAssembledStructure(ThreeBush, overworld, 7, 14)
    --drawLevelTable(titlescreen, tilemap, overworld)
    drawTable(Pa1_tilemap, Pa1_tileTable, titlescreen)
    drawTable(Pa2_tilemap, Pa2_tileTable, ninePatchTableTest)

    -- title
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- cursor
    love.graphics.draw(logo, (240-(logo:getWidth() / 2)), 25) -- this centers the logo on the X some fucking how what the 😭
    love.graphics.draw(menus, (260-(menus:getWidth() / 2)), 150)
    if (cursorSettings == 1) then
        love.graphics.draw(menuCursor, 184, 150)
    elseif (cursorSettings == 2) then
        love.graphics.draw(menuCursor, 184, 167)
    end
end

function runHomeScreen(dt)

end

function loadHomeScreen()
    prepareLevelCollisionTable(titlescreen)
end

function love.keypressed(key, scancode, isrepeat)
    if GAME_STATE == "HomeScreen" then
        if key == "up" then
            cursorSettings = 1
        elseif key == "down" then
            cursorSettings = 2
        end
    end
end
