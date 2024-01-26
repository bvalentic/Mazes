require 'grid'
require 'aldous_broder'

grid = Grid.new(30, 30)
AldousBroder.on(grid)

filename = "aldous_broder_maze.png"
grid.to_png.save(filename)
puts "saved to #{filename}"
