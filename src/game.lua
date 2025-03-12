require("atlas")
require("levelFormat")


-- Home's new screens
cursorSettings = 1
function drawHomeScreen()
    -- graphics
    local logo = love.graphics.newImage("assets/logo.png")
    local menus = love.graphics.newImage("assets/menus.png")
    

    love.graphics.setFont(font)

    --Render the homescreen!
    -- tiles decorations
    tileX = 1
    tileY = 1
    drawLevelFile(level)

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
    GAME_STATE = "HomeScreen"
    prepareLevelCollisionTable(titlescreen)
end
