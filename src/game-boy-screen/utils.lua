-- utils GB screen

local currentModule = ...
print ('loaded', currentModule)

local function resize (w, h)

end

return function (GBScreen)

	local Screen = GBScreen
	love.graphics.setDefaultFilter( "nearest", "nearest" )
	love.graphics.setLineStyle( "rough" )

	Screen.resize = function (w, h)
		local windowWidth = w or love.graphics.getWidth()
		local windowHeight = h or love.graphics.getHeight()
		local scaleW = windowWidth/Screen.GB_Width
		local scaleH = windowHeight/Screen.GB_Height
--		print ('width', windowWidth, Screen.GB_Width, scaleW)
--		print ('height', windowHeight, Screen.GB_Height, scaleH)
		Screen.scale = math.floor (math.min (scaleW, scaleH))
		Screen.dpiscale = 1/Screen.scale

		print ('dpiscale', Screen.dpiscale)

		local width = Screen.GB_Width / Screen.dpiscale
		local height = Screen.GB_Height / Screen.dpiscale

		Screen.canvasX = (windowWidth-width)/2
		Screen.canvasY = (windowHeight-height)/2

		Screen.canvas = love.graphics.newCanvas(Screen.GB_Width, Screen.GB_Height)

		love.graphics.setCanvas(GBScreen.canvas)
		love.graphics.setColor (1,1,1)
		love.graphics.rectangle ('fill', 0, 0, Screen.GB_Width, Screen.GB_Height)
		love.graphics.setCanvas()

		print ('resized', windowWidth, windowHeight)
	end


	love.window.setMode( 1280, 800, {resizable = Screen.resizable} )

	Screen.resize ()

	
	
end

