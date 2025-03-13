-- "Convert Color" - returns actual LOVE color number from a RGB value.
function cC(num) return num / 255 end

-- "Convert Color(s)" - same thing but all 3!
function cRGB(red, green, blue) -- alpha shouldn't really be needed since this is a remake of a nes game
    return (red / 255), (green / 255), (blue / 255)
end



function ScaleForScreen()
    love.graphics.scale(getScreenScaleFactors())
end

-- "get scale factors" calculates scale factors
-- we're already scaling it up 4 times so this is probably fucking horseshit

function getScreenScaleFactors()
    local width, height = love.window.getDesktopDimensions()
    local gameW, gameH = 480, 270
    local WFactor, HFactor = 4
    WFactor = width / gameW
    HFactor = height / gameH

    return WFactor, HFactor
end -- that was really clean, actually.

function round16(num)
    -- Make it an integer first
    num = math.floor(num + 0.5)
    -- Round to nearest 16
	num = math.floor(num / 16 + 0.5) * 16
    return num
end

-- Tables area

function table.clone(org)
    return {unpack(org)}
end

function tablelength(T)
    if T ~= nil then
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    else
        return nil
    end
end

-- junk i'll use soon

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

function checkBoundingBoxAndXY(x1,y1,w1,h1, x2,y2)
    if x2 > x1 and x2 < x1+w1 and y2 > y1 and y2 < y1+h1 then
        return true
    else
        return false
    end
end