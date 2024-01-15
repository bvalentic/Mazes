class Cell
    attr_reader :row, :column
    attr_accessor :north, :south, :east, :west

    def initialize(row, column)
        @row, @column = row, column
        @links = {}
    end
    