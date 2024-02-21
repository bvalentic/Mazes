require 'grid'
require 'recursive_backtracker'

grid = Grid.new(5, 5)

# orphan the cell in the NW corner...
grid[0, 0].east.west = nil
grid[0, 0].north.south = nil

# ...and the one in the SE corner
grid[4, 4].east.west = nil
grid[4, 4].north.south = nil

RecursiveBacktracker.on(grid, start_at: grid[1, 1])

puts grid
