require("lib")


function love.load()
    love.graphics.setBackgroundColor(cRGB(148,148,255))
    love.graphics.setDefaultFilter("nearest", "nearest")
    Obama = love.graphics.newImage("assets/Obmama.png")
    logo = love.graphics.newImage("assets/logo.png")
end

function love.draw()
    ScaleForScreen()
    love.graphics.draw(logo, (240-(logo:getWidth() / 2)), 25) -- this centers the logo on the X some fucking how what the 😭
end