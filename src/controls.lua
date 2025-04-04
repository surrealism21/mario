require("editor")

function love.keypressed(key, scancode, isrepeat)
    if GAME_STATE == "HomeScreen" then
        if key == "up" then
            cursorSettings = 1
        elseif key == "down" then
            cursorSettings = 2
        elseif key == "l" then 
            GAME_STATE = "editor"
            LEVEL_EDITOR_SETUP(level)
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    -- We fucking hate istouch. No mobile
    if GAME_STATE == "editor" then
        if button == 2 then
            if currentSystem == "tilemap" then
                initialMouseX, initialMouseY = mousePosition()
            end
        elseif button == 1 then
            lastSystem = currentSystem
            EDITOR_CLICK()
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if GAME_STATE == "editor" then
        if button == 2 then
            if currentSystem == "tilemap" then
                EDITOR_PLACE()
            end
        end
    end
end

function love.wheelmoved(x, y)
    if y > 0 then
        currentTile[1] = currentTile[1] + 1
    elseif y < 0 then
        currentTile[1] = currentTile[1] - 1
    end
end
