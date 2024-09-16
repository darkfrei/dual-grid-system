print ('loaded', ...)

-- GBS - game-boy-screen
-- https://github.com/darkfrei/gb-screen

local GBS = {}

require (... ..'.config')(GBS) -- wow!
require (... ..'.utils')(GBS) -- wow!

-- API

function GBS.drawCanvas ()
	love.graphics.setColor (1,1,1)
	love.graphics.draw(GBS.canvas, GBS.canvasX, GBS.canvasY, 0, GBS.scale)
end


function GBS.getPixel (x, y)
	x = x or love.mouse.getX( )
	y = y or love.mouse.getY( )
	local dx = GBS.canvasX
	local dy = GBS.canvasY
	local scale = GBS.scale

	-- canvas from position 0,0
	x = math.floor((love.mouse.getX( )-dx)/scale)
	y = math.floor((love.mouse.getY( )-dy)/scale)
	
	
	return x, y, x > 0 and y > 0 and x < GBS.GB_Width and y < GBS.GB_Height

end


return GBS




