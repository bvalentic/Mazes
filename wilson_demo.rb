require 'grid'
require 'wilson'

grid = Grid.new(20, 20)
Wilson.on(grid)

filename = "wilson.png"
grid.to_png.save(filename)
puts "saved to #{filename}"
