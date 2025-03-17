require("atlas")
-- sprite configurations for real-time level table
-- this does NOT actually contain sprite code
-- It's kind of like OOB but weirder. Made from scratch.

function spriteSystemPrepare() 
    sprites.Logo3.prepare()
    for i, v in pairs(sprites) do
        v.prepare()
    end
end



sprites = { -- epic megatable for Sprites
    Logo3 = {
        prepare,
        -- Sprite width and height
        width = 42,
        height = 48,

        -- Animations, if they exist
        animations = {
            Logo3 = {1, 4},
        },
    }
}