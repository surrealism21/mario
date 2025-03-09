-- "Convert Color" - returns actual LOVE color number from a RGB value.
function cC(num) return num / 255 end

-- "Convert Color(s)" - same thing but all 3!
function cRGB(red, green, blue) -- alpha shouldn't really be needed since this is a remake of a nes game
    return (red / 255), (green / 255), (blue / 255)
end

-- "Scale for screen" fucks with love.graphics.scale in order to retain to the user's needs without us having any Garbages.
-- we're already scaling it up 4 times so this is probably fucking horseshit

function ScaleForScreen() -- 1920 x 1080 is the cool base, aka my computer. There's it's 4x scale required.
    local width, height = love.window.getDesktopDimensions()
    local VW, VH = 1920, 1080 -- assuming you actually have a typical monitor Lmfao
    local gameW, gameH = 480, 270
    WFactor = width / gameW
    HFactor = height / gameH
    love.graphics.scale(WFactor, HFactor)
end
-- that was really clean, actually.

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
