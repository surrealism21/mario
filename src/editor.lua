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
function LEVEL_EDITOR_SETUP(LEVEL_NAME)
    currentSystem = "tilemap"
    levelEditorLevel = LEVEL_NAME
    show_layer = {true, true, true}
    editing_palette = 1
    editing_layer = 1
    currentTile = {1, 1}
end


function getCurrentTileTable() return levelEditorLevel["Pa"..tostring(editing_palette).."_tileTable"] end


placingGridQuadrant = 1

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

        if currentSystem == "tilemap" then
            -- Preview tiles shit

            -- actually draw the tile
            love.graphics.setColor(1, 1, 1, 0.5) -- 50% transparent
            
            if love.mouse.isDown(2) then
                drawTileSquare(currentTilemap, currentTileTable.tiles[getTile(currentTileTable, currentTile[1], currentTile[2])], getQuadrantPlacingShit(placingGridQuadrant))
            else
                love.graphics.draw(currentTilemap, currentTileTable.tiles[getTile(currentTileTable, currentTile[1], currentTile[2])], mousePosition())
            end
            love.graphics.setColor(1, 1, 1, 1) 
        end
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
    if love.mouse.isDown(2) then
        if currentSystem == "tilemap" then
            gridQuadrantMath()
            finalMouseX, finalMouseY = mousePosition()
        end
    end
end

function EDITOR_PLACE()
    local PaNo = levelEditorLevel.Pa[editing_palette]
    local layer = PaNo[editing_layer]
    table.insert(layer.squares, {currentTile[1], currentTile[2], getQuadrantPlacingShit(placingGridQuadrant)})
end

function gridQuadrantMath()
    if finalMouseY > initialMouseY or finalMouseY < initialMouseY and finalMouseX > initialMouseX or finalMouseX < initialMouseX then
        if finalMouseX > initialMouseX and finalMouseY > initialMouseY then
            placingGridQuadrant = 1
        elseif finalMouseX < initialMouseX and finalMouseY > initialMouseY then
            placingGridQuadrant = 2
        elseif finalMouseX < initialMouseX and finalMouseY < initialMouseY then
            placingGridQuadrant = 3
        elseif finalMouseX > initialMouseX and finalMouseY < initialMouseY then
            placingGridQuadrant = 4
        end
    elseif finalMouseX == initialMouseX then -- bar of tiles on the Y
        -- there may seem like there's duplicates here but the powers that be require it
        if finalMouseY > initialMouseY then
            placingGridQuadrant = 1
        elseif finalMouseY > initialMouseY then
            placingGridQuadrant = 2
        elseif finalMouseY < initialMouseY then
            placingGridQuadrant = 3
        elseif finalMouseY < initialMouseY then
            placingGridQuadrant = 4
        end
    else -- if it's just a bar of tiles on the X
        if finalMouseX > initialMouseX then
            placingGridQuadrant = 1
        elseif finalMouseX > initialMouseX then
            placingGridQuadrant = 2
        elseif finalMouseX < initialMouseX then
            placingGridQuadrant = 3
        elseif finalMouseX < initialMouseX then
            placingGridQuadrant = 4
        end
    end
end

function getQuadrantPlacingShit(quadrant)
    if quadrant == 1 then return (initialMouseX-1) / 16, (initialMouseY-1) / 16, (((finalMouseX-1) / 16) - (initialMouseX-1)/16) + 1, (((finalMouseY-1) / 16) - (initialMouseY -1)/16) + 1
    elseif quadrant == 3 then return (finalMouseX-1) / 16, (finalMouseY-1) / 16, (((initialMouseX-1) / 16) - (finalMouseX-1)/16) + 1, (((initialMouseY-1) / 16) - (finalMouseY -1)/16) + 1 -- direct opposite, easier
    elseif quadrant == 2 then return (finalMouseX-1) / 16, (initialMouseY-1) / 16, (((initialMouseX-1) / 16) - (finalMouseX-1)/16) + 1, (((finalMouseY-1) / 16) - (initialMouseY -1)/16) + 1
    elseif quadrant == 4 then return (initialMouseX-1) / 16, (finalMouseY-1) / 16, (((finalMouseX-1) / 16) - (initialMouseX-1)/16) + 1, (((initialMouseY-1) / 16) - (finalMouseY -1)/16) + 1
    end
end

function EDITOR_SELECT()
    mx, my = mousePosition()
    --First, if the player's editing tiles
    if currentSystem == "tilemap" then
        local PaNo = levelEditorLevel.Pa[editing_palette]
        local layer = PaNo[editing_layer]
        for squareCheck = 1, tablelength(layer.squares) do
            local squareTable = layer.squares[squareCheck]
            if checkBoundingBoxAndXY(squareTable[3], squareTable[4], squareTable[5], squareTable[6], mx/16, my/16) == true then
                -- yeah for now this just deletes it, selection to morrow
                layer.squares[squareCheck] = nil
            end
        end
    end
end
