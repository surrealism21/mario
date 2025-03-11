require("atlas")
require("level")



function LEVEL_EDITOR_SETUP()
    levelEditorLevel = level
    show_layer = {true, true, true}
end

function love.mousepressed(mx, my, button) 
    
end



function drawEditor()
    for Pa = 1, tablelength(levelEditorLevel.Pa) do
        local currentTilemap = levelEditorLevel["Pa"..tostring(Pa).."_tilemap"]
        local currentTileTable = levelEditorLevel["Pa"..tostring(Pa).."_tileTable"]
        local PaNo = levelEditorLevel.Pa[Pa]

        -- Draw layer 1
        if PaNo[1] ~= nil and show_layer[1] == true then
            drawTable(currentTilemap, currentTileTable, PaNo[1])
        end
        -- Draw layer 2
        if PaNo[2] ~= nil and show_layer[2] == true then
            drawTable(currentTilemap, currentTileTable, PaNo[2])
        end
        -- Draw layer 3
        if PaNo[3] ~= nil and show_layer[3] == true then
            drawTable(currentTilemap, currentTileTable, PaNo[3])
        end
    end
end

function runEditor(dt)
    mx, my = love.mouse.getPosition()
end

function LEVEL_EDITOR_FINALIZE() -- saves our level to a file

end
