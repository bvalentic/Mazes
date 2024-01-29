require 'colored_grid'
require 'binary_tree'
require 'sidewinder'
require 'aldous_broder'
require 'wilson'

6.times do |n|
    grid = ColoredGrid.new(20, 20)
    AldousBroder.on(grid)

    middle = grid[grid.rows / 2, grid.columns / 2]
    grid.distances = middle.distances

    filename = "aldous_broder_maze_%02d.png" % n
    grid.to_png.save(filename)
    puts "saved to #{filename}"
end
