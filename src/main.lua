require("lib")
require("atlas")
require("game")

function love.load()
    font = love.graphics.newFont("assets/font.ttf")
    love.graphics.setBackgroundColor(sky)
    
    Obama = love.graphics.newImage("assets/Obmama.png")
	menuCursor = love.graphics.newImage("assets/menuCursor.png")
	bouns = {}
	bonus = createTileTable(bonusTilemap, 2, 5, 3)
	overworld = createTileTable(overworldTilemap, 1, 9, 8)
	Pa1_tilemap = overworldTilemap
	Pa1_tileTable = overworld
	Pa2_tilemap = bonusTilemap
	Pa2_tileTable = bonus
	loadHomeScreen()
end
cursorSettings = 1
function love.draw()
    ScaleForScreen()
    drawHomeScreen()
end

function love.run(dt) 
    runHomeScreen(dt)

    if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 0

	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end

		-- Update dt, as we'll be passing it to update
		if love.timer then dt = love.timer.step() end

		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())

			if love.draw then love.draw() end

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end
