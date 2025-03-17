require("lib")
require("atlas")
require("game")
require("editor")
require("controls")
require("sprites/logo3")
require("spriteSystem")

function love.load()
    font = love.graphics.newFont("assets/font.ttf")
    love.graphics.setBackgroundColor(sky)
    
    Obama = love.graphics.newImage("assets/Obmama.png")
	menuCursor = love.graphics.newImage("assets/menuCursor.png")
	love.mouse.setVisible(false)
	spriteSystemPrepare()

	loadHomeScreen()
end
cursorSettings = 1
function love.draw()
    ScaleForScreen()
	if GAME_STATE == "HomeScreen" then
		drawHomeScreen(dt)
	elseif GAME_STATE == "editor" then
		drawEditor()
	end
end

function love.update(dt) 
	--require("lovebird").update()
	if GAME_STATE == "HomeScreen" then
		runHomeScreen(dt)
	elseif GAME_STATE == "editor" then
		runEditor(dt)
	end
	mousePosition()
end
