require 'cell'
require 'chunky_png'

class Grid
    attr_reader :rows, :columns

    def initialize(rows, columns)
        @rows = rows
        @columns = columns

        @grid = prepare_grid
        configure_cells
    end

    def prepare_grid
        Array.new(rows) do |row|
            Array.new(columns) do |column|
                Cell.new(row, column)
            end
        end
    end

    def configure_cells
        each_cell do |cell|
            row, col = cell.row, cell.column
            
            cell.north = self[row - 1, col]
            cell.south = self[row + 1, col]
            cell.east = self[row, col + 1]
            cell.west = self[row, col - 1]
        end
    end

    def [](row, column)
        return nil unless row.between?(0, @rows - 1)
        return nil unless column.between?(0, @grid[row].count - 1)
        @grid[row][column]
    end

    def random_cell
        row = rand(@rows)
        column = rand(@grid[row].count)

        self[row, column]
    end

    def size
        @rows * columns
    end

    def each_row
        @grid.each do |row|
            yield row
        end
    end

    def each_cell
        each_row do |row|
            row.each do |cell|
                yield cell if cell
            end
        end
    end

    def contents_of(cell)
        " "
    end

    def background_color_for(cell)
        nil
    end

    def to_s
        output = "+" + "---+" * columns + "\n"

        each_row do |row|
            top = "|"
            bottom = "+"

            row.each do |cell|
                cell = Cell.new(-1, 1) unless cell

                body = " #{contents_of(cell)} " # print 3 blank spaces unless overridden (for printing Dijkstra's algorithm, etc.)
                east_boundary = (cell.linked?(cell.east) ? " " : "|")
                top << body << east_boundary

                south_boundary = (cell.linked?(cell.south) ? "   " : "---") # also 3 spaces
                corner = "+"
                bottom << south_boundary << corner
            end

            output << top << "\n"
            output << bottom << "\n"
        end

        output
    end

    def to_png(cell_size = 10)
        img_width = cell_size * columns
        img_height = cell_size * rows

        background = ChunkyPNG::Color('white')
        wall = ChunkyPNG::Color('black')

        img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)
        
        [:backgrounds, :walls].each do |mode|
            each_cell do |cell|
                x1 = cell.column * cell_size
                y1 = cell.row * cell_size
                x2 = (cell.column + 1) * cell_size
                y2 = (cell.row + 1) * cell_size
                
                if mode == :backgrounds
                    color = background_color_for(cell)
                    img.rect(x1, y1, x2, y2, color, color) if color
                else
                    img.line(x1, y1, x2, y1, wall) unless cell.north
                    img.line(x1, y1, x1, y2, wall) unless cell.west
                    img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
                    img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
                end
            end
        end

        img
    end
end
