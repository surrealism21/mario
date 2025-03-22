require("atlas")

-- uses atli
-- coming soon!!!

function animate(animation, tileTable, rectRightNow)
    if rectRightNow < animation[2] then
        return rectRightNow + 1
    elseif rectRightNow == animation[2] then
        return animation[1]
    end
end
