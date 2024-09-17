# dual-grid-system
dual grid system for Lua

This lib makes multiple layers of tiles, as example the tile size is 12 pixels.

Input file: one spritesheet 5x3 tiles, but it works like full 47 tiles spritesheet.

See:
![Alt text](https://github.com/darkfrei/dual-grid-system/blob/main/Animation%20(94).gif "Optional title")


## Example

```lua
-- main.lua
local DGS = require ('src.dual-grid-system')

local grid = DGS.newGrid (12)

function love.load ()
  local texture = love.graphics.newImage('dual-grid-12.png')
  DGS.addLayer (grid, texture)

  DGS.addBlock (grid, 2, 1, 1) -- grid, x, y, layer
  DGS.addBlock (grid, 3, 2, 1)
  DGS.addBlock (grid, 1, 3, 1)
  DGS.addBlock (grid, 2, 3, 1)
  DGS.addBlock (grid, 3, 3, 1)
  -- glider!
end

function love.draw ()
  love.graphics.scale( 12, 12 )
  love.graphics.setColor (1,1,1)
  DGS.draw(grid)
end

```

