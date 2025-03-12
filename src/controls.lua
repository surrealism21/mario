function love.keypressed(key, scancode, isrepeat)
    if GAME_STATE == "HomeScreen" then
        if key == "up" then
            cursorSettings = 1
        elseif key == "down" then
            cursorSettings = 2
        elseif key == "l" then 
            GAME_STATE = "editor"
            LEVEL_EDITOR_SETUP(titlescreen)
        end
    elseif GAME_STATE == "editor" then

    end
end

function love.mousepressed(x, y, button, istouch, presses)
    -- We fucking hate istouch. No mobile
    if GAME_STATE == "editor" then
        if button == 1 then
            initialMouseX, initialMouseY = mousePosition()
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if GAME_STATE == "editor" then
        if button == 1 then
            EDITOR_PLACE()
        end
    end
end
