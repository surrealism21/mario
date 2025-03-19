require("atlas")

-- sprite configurations for real-time level table
-- this does NOT actually contain sprite code
-- It's kind of like OOB but weirder. Made from scratch.

function spriteSystemPrepare()
    for i, v in pairs(level.Sprites) do
        v.data.prepare()
    end
end

function spriteSystemRun()
    for i, v in pairs(level.Sprites) do
        xOk, yOk = v.data.run(v.x, v.y)
        v.x = xOk
        v.y = yOk
    end
end

function spriteSystemDraw()
    for i, v in pairs(level.Sprites) do
        v.data.draw(v.x, v.y)
    end
end



sprites = { -- epic megatable for Sprites
    Logo3 = {
        prepare,
        run,
        draw,
        -- Sprite width and height
        width = 42,
        height = 48,

        -- Animations, if they exist
        animationFrame = 1, -- You cannot play multiple animations. Multiple of these are not needed. This variable is not to be changed!!!
        -- note: weird animations currently are not implemented
        animations = {
            Logo3 = {1, 4, "linear"},
        },
    }
}