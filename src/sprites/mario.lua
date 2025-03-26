require("physics")



ma = {
    x = 10,
    y = 10,
    yV = 0,
    xV = 0,
}

function marioRun()
    marioControl()
    ma.x = ma.x + ma.xV
    --Physics
    physicsRun(ma)
end

function drawMario()
    love.graphics.draw(mario, ma.x, ma.y, 0)
end

function marioControl()
    keyRight = love.keyboard.isDown("right")
    keyLeft = love.keyboard.isDown("left")
    if keyRight == true then
        ma.xV = 1
    elseif keyLeft == true then
        ma.xV = -1
    end
end