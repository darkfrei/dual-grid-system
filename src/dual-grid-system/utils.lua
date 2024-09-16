-- DGS - dual-grid-system - utils

local currentModule = ...

print ('loaded', currentModule)

local utils = {}

function utils.defineQuads (cellSizePx, texture)
	local quads = {}

-- bitwise orientation; 0 is undefined
-- values represent different combinations of bits
	local bitNumbers = {
		1+2+8, 1+2+4, 4, 8, 4+8,
		1+4+8, 2+4+8, 2, 1, 1+2,
		2+4, 1+8, 2+8, 1+4, 1+2+4+8
	}

-- positions of quads on the texture atlas
-- each entry represents the (x, y) coordinates of a quad
	local positions = {
		{0,0}, {1,0}, {2,0}, {3,0}, {4,0}, 
		{0,1}, {1,1}, {2,1}, {3,1}, {4,1}, 
		{0,2}, {1,2}, {2,2}, {3,2}, {4,2}
	}

-- loop through each bit number
	for i = 1, #bitNumbers do
-- bit number for the current quad
		local index = bitNumbers[i]

-- get the position of the current quad
		local x, y = positions[i][1], positions[i][2]
		-- define quad
		quads[index] = love.graphics.newQuad (x*cellSizePx, y*cellSizePx, cellSizePx, cellSizePx, texture)
	end

	return quads
end

function utils.newGrid (cellSizePx)
	local grid = {}
	grid.layers = {}
	grid.cellSizePx = cellSizePx -- same for all layers
	print ('newGrid', cellSizePx)
	return grid
end

function utils.addLayer (grid, texture)
	local layer = {}
	layer.tiles = {}
	layer.sprites = {}
	layer.quads = utils.defineQuads (grid.cellSizePx, texture)
	layer.texture = texture
	table.insert (grid.layers, layer)
	print ('new layer', #grid.layers)
end

local bitPositions = {{0,0,1}, {1,0,2}, {1,1,4}, {0,1,8}}



local function updateLayer (layer, x, y)
	local sumBits = 0
	for i, bitpos in ipairs (bitPositions) do
		local dx, dy, bitValue = bitpos[1], bitpos[2], bitpos[3]
		if layer.tiles[y+dy] and layer.tiles[y+dy][x+dx] then
			sumBits = sumBits + bitValue
		end
	end
	layer.sprites[y] = layer.sprites[y] or {}
--	print ('sumBits',sumBits)
	if sumBits > 0 then
		layer.sprites[y][x] = layer.quads[sumBits]
	else
		layer.sprites[y][x] = nil
	end
end

function utils.addBlock (grid, x, y, value)
	local layer = grid.layers[value]
	if layer then
		layer.tiles[y] = layer.tiles[y] or {}
		layer.tiles[y][x] = true
		for dx = -1, 0 do
			for dy = -1, 0 do
--				print ('updating', x+dx, y+dy, value)
				updateLayer (layer, x+dx, y+dy, value)
			end
		end
	end
end


function utils.removeBlock (grid, x, y, value)
	local layer = grid.layers[value]
	if layer then
		layer.tiles[y] = layer.tiles[y] or {}
		layer.tiles[y][x] = false
		for dx = -1, 0 do
			for dy = -1, 0 do
				updateLayer (layer, x+dx, y+dy, value)
			end
		end
	end
end

function utils.draw(grid)
	love.graphics.setColor(1,1,1)
	local size = grid.cellSizePx
	for i, layer in ipairs (grid.layers) do
		local texture = layer.texture
		for y, xs in pairs (layer.sprites) do
			for x, quad in pairs (xs) do
				local dx = x*size - size/2
				local dy = y*size - size/2
				love.graphics.draw (texture, quad, dx, dy)
			end
		end
	end
end

return utils