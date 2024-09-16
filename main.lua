local GBS = require ('src.game-boy-screen')

local DGS = require ('src.dual-grid-system')

function love.resize(w, h)
	print(("Window resized to width: %d and height: %d."):format(w, h))
	GBS.resize ()
end

local backimg = love.graphics.newImage('backimg.png')

local texture = love.graphics.newImage('dual-grid-12.png')

local grid = DGS.newGrid (12)

DGS.addLayer (grid, texture)

--DGS.addBlock (grid, 1, 1, 1)
--DGS.addBlock (grid, 2, 2, 1)
--DGS.addBlock (grid, 2, 3, 1)
--DGS.addBlock (grid, 2, 4, 1)
--DGS.addBlock (grid, 3, 4, 1)
--DGS.addBlock (grid, 5, 4, 1)
DGS.addBlock (grid, 13, 12, 2)

for x = 1, 13 do
	for y = 1, 12 do
		if math.random () < 0.2 then
			DGS.addBlock (grid, x, y, 1)
		end
	end
end


function love.draw ()
	love.graphics.setColor (1,1,1)
	love.graphics.draw (backimg)
	
	love.graphics.setCanvas(GBS.canvas)
	love.graphics.setColor (1,1,1)
	love.graphics.rectangle ('fill', 0, 0, GBS.GB_Width, GBS.GB_Height)
	love.graphics.setColor (0,0,0)
	love.graphics.line (0,0, 160, 144)
	love.graphics.line (0,144, 160, 0)

	DGS.draw(grid)
	
	
	local x,y, w, h = DGS.getCursor(grid, GBS.getPixel (love.mouse.getPosition()))
	love.graphics.setColor (0.8,0.8,0)
	love.graphics.rectangle ('line', x, y, w, h)
	
	love.graphics.setCanvas()


	GBS.drawCanvas ()


end

function love.mousemoved ( x, y, dx, dy, istouch )
	local px, py, scale = GBS.getPixel (x, y)
--	love.window.setTitle (px ..' '.. py)
	local tx, ty = DGS.getTile (grid, px, py)
	love.window.setTitle (px..' '..py..' '.. tx ..' '.. ty)
	if love.mouse.isDown( 1 ) then
		DGS.addBlock (grid, tx, ty, 1)
	elseif love.mouse.isDown( 2 ) then
		DGS.removeBlock (grid, tx, ty, 1)
	end
end

function love.mousereleased(x, y, button)
	local tx, ty = DGS.getTile (grid, GBS.getPixel (x, y))
	if button == 1 then
		DGS.addBlock (grid, tx, ty, 1)
	elseif button == 2 then
		DGS.removeBlock (grid, tx, ty, 1)
	end
end
