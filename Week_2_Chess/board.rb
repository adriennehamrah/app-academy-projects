require_relative 'piece'

class Board
  attr_accessor :grid

  def initialize()
    @null = NullPiece.instance
    @grid = self.populate
  end

  def populate
    grid = Array.new(8){ Array.new(8) { @null } }

    [0,7].each { |col| grid[0][col] = Rook.new(:blue, [0, col], self)}
    [1,6].each { |col| grid[0][col] = Horse.new(:blue, [0, col], self)}
    [2,5].each { |col| grid[0][col] = Bishop.new(:blue, [0, col], self)}
    [3].each { |col| grid[0][col] = Queen.new(:blue, [0, col], self)}
    [4].each { |col| grid[0][col] = King.new(:blue, [0, col], self)}
    (0..7).each { |col| grid[1][col] = Pawn.new(:blue, [1, col], self)}


    (0..7).each { |col| grid[6][col] = Pawn.new(:white, [6, col], self)}
    [0,7].each { |col| grid[7][col] = Rook.new(:white, [7, col], self)}
    [1,6].each { |col| grid[7][col] = Horse.new(:white, [7, col], self)}
    [2,5].each { |col| grid[7][col] = Bishop.new(:white, [7, col], self)}
    [3].each { |col| grid[7][col] = Queen.new(:white, [7, col], self)}
    [4].each { |col| grid[7][col] = King.new(:white, [7, col], self)}

    grid
  end

  def [](pos) # allows us to access piece directly
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    if valid_move? == false || self[start_pos].is_a?(NullPiece)
      raise StandardError.new('Please enter a valid move.')
    end

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]

    self[end_pos].current_pos = end_pos
    # update taken piece
  end

  def valid_move?
    return true
    # off the board - board size
    # direction is allowed - moves - depend on type of piece
    # check if piece in way - unless the piece is taking the piece
    # check if piece is your piece at end pos.

  end
end
