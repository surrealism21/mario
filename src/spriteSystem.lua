require("atlas")

-- sprite configurations for real-time level table
-- this does NOT actually contain sprite code
-- It's kind of like OOB but weirder. Made from scratch.

function spriteSystemPrepare()
    for i, v in pairs(level.Sprites) do
        level.Sprites[i].data.prepare()
    end
end

function spriteSystemRun()
    for i, v in pairs(level.Sprites) do
        level.Sprites[i].data.run()
    end
end



sprites = { -- epic megatable for Sprites
    Logo3 = {
        prepare,
        run,
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