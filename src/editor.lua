require("atlas")
require("level")
require("lib")
require("game")

function mousePosition()
    local mx, my = love.mouse.getPosition()
    -- Mouse position relative to screen size
    WFactor, HFactor = getScreenScaleFactors()
    mx = mx / WFactor
    my = my / HFactor
    mx = round16(mx)
    my = round16(my)

    return mx, my
end


currentTile = 1
function LEVEL_EDITOR_SETUP()
    levelEditorLevel = level
    show_layer = {true, true, true}
    editing_palette = 1
    editing_layer = 1
    currentTile = {1, 1}
end


function getCurrentTileTable() return levelEditorLevel["Pa"..tostring(editing_palette).."_tileTable"] end



function drawEditor()
    love.graphics.setColor(1, 1, 1, 1)
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

        -- Preview tiles shit

        -- actually draw the tile
        love.graphics.setColor(1, 1, 1, 0.5) -- 50% transparent
        
        if love.mouse.isDown(1) then
            drawTileSquare(currentTilemap, currentTileTable.tiles[getTile(currentTileTable, currentTile[1], currentTile[2])], (initialMouseX-1) / 16, (initialMouseY-1) / 16, (((finalMouseX-1) / 16) - (initialMouseX-1)/16) + 1, (((finalMouseY-1) / 16) - (initialMouseY -1)/16) + 1)
        else
            love.graphics.draw(currentTilemap, currentTileTable.tiles[getTile(currentTileTable, currentTile[1], currentTile[2])], mousePosition())
        end
        love.graphics.setColor(1, 1, 1, 1) 
    end

    -- begin buttons
    love.graphics.draw(paletteButton, 0, 0, 0, 0.5, 0.5)
    -- other
    love.graphics.print("initial mouse pos: "..tostring(initialMouseX / 16)..", "..tostring(initialMouseY / 16), 0, 30, 0, 0.25, 0.25)
    love.graphics.print("final mouse pos: "..tostring(finalMouseX / 16)..", "..tostring(finalMouseY / 16), 0, 50, 0, 0.25, 0.25)
end

-- tile palette button. At 0,0
paletteButton = love.graphics.newImage("assets/buttons/palette.png")

function tilePaletteShow()
end

-- Related to placing tiles
-- Ok
initialMouseX = 1
initialMouseY = 1
finalMouseX = 2
finalMouseY = 2
function runEditor(dt)
    if love.mouse.isDown(1) then
        finalMouseX, finalMouseY = mousePosition()
    end
end

function EDITOR_PLACE()
    local PaNo = levelEditorLevel.Pa[editing_palette]
    local layer = PaNo[editing_layer]
    
    table.insert(layer.squares, {currentTile[1], currentTile[2], (initialMouseX-1) / 16, (initialMouseY-1) / 16, (((finalMouseX-1) / 16) - (initialMouseX-1)/16) + 1, (((finalMouseY-1) / 16) - (initialMouseY -1)/16) + 1})
    --initialMouseX, initialMouseY, finalMouseX, finalMouseY = 0
end

function LEVEL_EDITOR_FINALIZE() -- saves our level to a file
end
