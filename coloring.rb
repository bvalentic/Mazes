require 'colored_grid'
require 'binary_tree'
require 'sidewinder'
require 'aldous_broder'
require 'wilson'

grid = ColoredGrid.new(50, 50)
AldousBroder.on(grid)

start = grid[grid.rows / 2, grid.columns / 2]

grid.distances = start.distances

filename = "colorized.png"
grid.to_png.save(filename)
puts "saved to #{filename}"
