require 'byebug'
require 'colorize'
require 'singleton'

class Piece
  attr_accessor :current_pos
  attr_reader :symbol, :color, :move_dir, :board

  def initialize(color, pos, board)
    @color = color
    @current_pos = pos
    @board = board
  end
end

module SlidingPiece
  STRAIGHT = [[-1,0], [1,0], [0,1], [0, -1]]
  DIAGONAL = [[1,1], [-1,-1], [1,-1], [-1,1]]

  def move_dir
    if self.is_a?(Queen)
      STRAIGHT + DIAGONAL
    elsif self.is_a?(Rook)
      STRAIGHT
    elsif self.is_a?(Bishop)
      DIAGONAL
    end
  end

  def moves
    possible_moves = []
    move_dir.each do |single_dir|
      temp_pos = self.current_pos.dup

      while true
        temp_pos[0] += single_dir[0]
        temp_pos[1] += single_dir[1]

        in_bounds = temp_pos[0].between?(0, 7) && temp_pos[1].between?(0, 7)
        break unless in_bounds

        no_blocker = @board[temp_pos].is_a?(NullPiece) || @board[temp_pos].color != self.color
        break unless no_blocker

        possible_moves << temp_pos.dup
        break if !@board[temp_pos].is_a?(NullPiece) && @board[temp_pos].color != self.color
      end
    end

    possible_moves
  end
end

module StepPiece
  KNIGHT = [[-1,-2], [1,2], [-1,2], [1, -2], [-2,-1], [2,1], [-2,1], [2, -1]]
  KING = [[1,1], [-1,-1], [1,-1], [-1,1], [-1,0], [1,0], [0,1], [0, -1]]

  def move_dir
    if self.is_a?(Horse)
      KNIGHT
    elsif self.is_a?(King)
      KING
    end
  end

  def moves
    possible_moves = []
    move_dir.each do |single_dir|
      temp_pos = self.current_pos.dup

      temp_pos[0] += single_dir[0]
      temp_pos[1] += single_dir[1]

      in_bounds = temp_pos[0].between?(0, 7) && temp_pos[1].between?(0, 7)

      no_blocker = @board[temp_pos].is_a?(NullPiece) || @board[temp_pos].color != self.color

      possible_moves << temp_pos.dup if in_bounds && no_blocker
    end

    possible_moves
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @color = :nil
    @symbol = " "
  end
end

class Rook < Piece
  include SlidingPiece
  def initialize(color, pos, board)
    @symbol = 'R'
    super
  end
end

class Horse < Piece
  include StepPiece
  def initialize(color, pos, board)
    @symbol = 'H'
    super
  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(color, pos, board)
    @symbol = 'B'
    super
  end
end

class Queen < Piece
  include SlidingPiece
  def initialize(color, pos, board)
    @symbol = 'Q'
    super
  end
end

class King < Piece
  include StepPiece
  def initialize(color, pos, board)
    @symbol = 'K'
    super
  end
end

class Pawn < Piece

  def initialize(color, pos, board)
    @symbol = 'P'
    super
  end
end
