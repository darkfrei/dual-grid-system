-- DGS - dual-grid-system - init

local currentModule = ...

print ('loaded', currentModule)

local utils = require(currentModule..".utils")

print (type (utils.newGrid))

local DGS = {}


function DGS.newGrid (cellSizePx)
	return utils.newGrid (cellSizePx)
end

function DGS.addLayer (grid, texture)
	return utils.addLayer (grid, texture)
end

function DGS.addBlock (grid, x, y, value)
	return utils.addBlock (grid, x, y, value)
end

function DGS.removeBlock (grid, x, y, value)
	return utils.removeBlock (grid, x, y, value)
end



function DGS.getTile (grid, px, py)
	local cellSizePx = grid.cellSizePx
	local tx = math.ceil(px/cellSizePx)
	local ty = math.ceil(py/cellSizePx)
	return tx, ty
end

function DGS.getCursor(grid, px,py)
	local cellSizePx = grid.cellSizePx
	local tx, ty = DGS.getTile (grid, px, py)
	local x, y = (tx-1) * cellSizePx , (ty-1) * cellSizePx 
	return x, y, cellSizePx+1, cellSizePx+1
end

function DGS.draw(grid)
	return utils.draw(grid)
end

return DGS