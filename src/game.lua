require("atlas")
require("levelFormat")
require("animatedSprite")


-- Home's new screens
cursorSettings = 1
local logo = love.graphics.newImage("assets/logo.png")
local menus = love.graphics.newImage("assets/menus.png")
logoLocale = { x = 240, y = 25}
function drawHomeScreen(dt)
    love.graphics.setFont(font)
    --Render the homescreen!
    -- tiles decorations
    tileX = 1
    tileY = 1
    drawLevelFile(level)

    -- title
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- cursor
    love.graphics.draw(logo, (logoLocale.x-(logo:getWidth() / 2)), logoLocale.y) -- this centers the logo on the X some fucking how what the 😭
    love.graphics.draw(menus, (260-(menus:getWidth() / 2)), 200)
    love.graphics.draw(menuCursor, 184, 200)
end

function runHomeScreen(dt)

end

function loadHomeScreen()
    GAME_STATE = "HomeScreen"
end
