p = {
    FRICTION = 0.05,
    GRAVITY = 3,
}

function physicsRun(table)
    if table.xV > 0.01 then
        table.xV = table.xV - p.FRICTION
    elseif table.xV < -0.01 then
        table.xV = table.xV + p.FRICTION
    end
end

