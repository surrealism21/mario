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
    editing_palette_tileTable = levelEditorLevel["Pa"..tostring(editing_palette).."_tileTable"]
    editing_palette_tilemap = levelEditorLevel["Pa"..tostring(editing_palette).."_tilemap"]
    editing_layer = 1
    currentTile = {1, 1}
end


function getCurrentTileTable() return levelEditorLevel["Pa"..tostring(editing_palette).."_tileTable"] end


placingGridQuadrant = 1

function drawEditor()
    editorScrollingDraw()
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
    end

    -- begin buttons
    love.graphics.draw(paletteButton, 0, 0, 0, 0.5, 0.5)
    -- other
    love.graphics.print("initial mouse pos: "..tostring(initialMouseX / 16)..", "..tostring(initialMouseY / 16), 0, 30, 0, 0.25, 0.25)
    love.graphics.print("final mouse pos: "..tostring(finalMouseX / 16)..", "..tostring(finalMouseY / 16), 0, 50, 0, 0.25, 0.25)

    -- UI's
    if tilePaletteShow == true then
        love.graphics.draw(editing_palette_tilemap, 0, 32 / 2, 0, 1, 1)
    end

    if currentSystem == "tilemap" then
        love.mouse.setVisible(false)
        -- Preview tiles shit

        -- actually draw the tile
        love.graphics.setColor(1, 1, 1, 0.5) -- 50% transparent
        
        if not love.mouse.isDown(2) then
            love.graphics.draw(editing_palette_tilemap, editing_palette_tileTable.tiles[getTile(editing_palette_tileTable, currentTile[1], currentTile[2])], mousePosition())
        else
            drawTileSquare(editing_palette_tilemap, editing_palette_tileTable, editing_palette_tileTable.tiles[getTile(editing_palette_tileTable, currentTile[1], currentTile[2])], getQuadrantPlacingShit(placingGridQuadrant))
        end
        love.graphics.setColor(1, 1, 1, 1) 
    elseif currentSystem == "picker" then
        love.mouse.setVisible(true)
    end
end

-- tile palette button. At 0,0
paletteButton = love.graphics.newImage("assets/buttons/palette.png")
tilePaletteShow = false
function EDITOR_CLICK()
    paletteButtonLocale = {
        x = 0,
        y = 0,
        width = (paletteButton:getWidth() / 2) * WFactor,
        height = (paletteButton:getHeight() / 2) * HFactor,
    }
    tilemapLocale = {
        x = 0,
        y = 32 / 2,
        width = (editing_palette_tilemap:getWidth()) * WFactor,
        height = (editing_palette_tilemap:getHeight()) * HFactor,
    }
    if checkBoundingBoxAndXY(paletteButtonLocale.x, paletteButtonLocale.y, paletteButtonLocale.width, paletteButtonLocale.height, love.mouse.getPosition()) then
        if tilePaletteShow == false then
            tilePaletteShow = true
            currentSystem = "picker"
        else 
            tilePaletteShow = false
            currentSystem = "tilemap"
        end
    elseif checkBoundingBoxAndXY(tilemapLocale.x, tilemapLocale.y, tilemapLocale.width, tilemapLocale.height, love.mouse.getPosition()) then

    else 
        EDITOR_SELECT()
    end
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
    if quadrant == 1 then return (initialMouseX) / 16, (initialMouseY) / 16, (((finalMouseX) / 16) - (initialMouseX)/16), (((finalMouseY) / 16) - (initialMouseY)/16)
    elseif quadrant == 3 then return (finalMouseX) / 16, (finalMouseY) / 16, (((initialMouseX) / 16) - (finalMouseX)/16), (((initialMouseY) / 16) - (finalMouseY)/16) -- direct opposite, easier
    elseif quadrant == 2 then return (finalMouseX) / 16, (initialMouseY) / 16, (((initialMouseX) / 16) - (finalMouseX)/16), (((finalMouseY) / 16) - (initialMouseY)/16)
    elseif quadrant == 4 then return (initialMouseX) / 16, (finalMouseY) / 16, (((finalMouseX) / 16) - (initialMouseX)/16), (((initialMouseY) / 16) - (finalMouseY)/16)
    end
end

function EDITOR_SELECT()
    mx, my = mousePosition()
    --First, if the player's editing tiles
    if currentSystem == "tilemap" then
        local PaNo = levelEditorLevel.Pa[editing_palette]
        local layer = PaNo[editing_layer]
        for i, v in pairs(layer.squares) do
            local squareTable = layer.squares[i]
            if squareTable ~= nil then
                if checkBoundingBoxAndXY(squareTable[3]-1, squareTable[4]-1, squareTable[5]+1, squareTable[6]+1, (mx/16), (my/16)) == true then
                    -- yeah for now this just deletes it, selection to morrow
                    layer.squares[i] = nil
                end
            end
        end
    end
end


-- Camera
tx=0
ty=0
function editorScrollingDraw()
	mx = love.mouse.getX()
	my = love.mouse.getY()
	if love.mouse.isDown(3) then
		if not mouse_pressed then
			mouse_preslsed = true
			dx = tx-mx
			dy = ty-my
		else
			tx = mx+dx
			ty = my+dy
		end
	elseif mouse_pressed then
		mouse_pressed = false
	end
	love.graphics.translate(tx, ty)
end

