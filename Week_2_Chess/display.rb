require 'colorize'
require 'byebug'
require_relative 'cursor'
require_relative 'board'

class Display
  def initialize(board)
    @cursor = Cursor.new([6,4], board)
    @board = board
  end

  def render

    system('clear')
    puts "---------------------------------"
    (0..7).each do |row|
      (0..7).each do |col|
        bg_color = :black
        pos = [row,col]
        print "| " if col == 0
        print " | " unless col == 0
        piece = @board.grid[row][col]
        bg_color = :yellow if @cursor.cursor_pos == pos
        print piece.symbol.colorize(:color => piece.color, :background => bg_color)
      end
      print " |"
      puts
      puts "---------------------------------"
    end
  end


  def play
    while true
      render
      @cursor.get_input
    end
  end
end
