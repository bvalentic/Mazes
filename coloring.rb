require 'colored_grid'
require 'binary_tree'
require 'sidewinder'
require 'aldous_broder'

grid = ColoredGrid.new(30, 30)
AldousBroder.on(grid)

start = grid[0, 0]

grid.distances = start.distances

filename = "colorized.png"
grid.to_png.save(filename)
puts "saved to #{filename}"
