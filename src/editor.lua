require("atlas")
require("level")

function LEVEL_EDITOR_SETUP()
    levelEditorLevel = titlescreen
end

levelEditorLevel = nil

function love.mousepressed(mx, my, button) 
    
end



function drawEditor()
    drawTable(Pa1_tilemap, Pa1_tileTable, levelEditorLevel)
end

function runEditor(dt)
    mx, my = love.mouse.getPosition()
end

function LEVEL_EDITOR_FINALIZE() -- saves our level to a file

end
