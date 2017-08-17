require_relative 'card.rb'

class Board
  attr_reader :size

  def initialize(size)
    @size = size
    @grid = Array.new (size) { Array.new(size) }
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,card)
    x,y = pos
    @grid[x][y] = card
  end

  def populate
    pair_count = @size**2 / 2
    pairs = (1..pair_count).to_a
    card_values = pairs + pairs

    fill_grid(@size, card_values)
  end

  def render
    print '    '
    @size.times { |col| print "#{col}   " }
    puts
    @size.times do |row|
      print "#{row} |"
      @size.times do |col|
        pos = [row,col]
        print "#{self[pos].display}|"
      end
      puts
    end
  end

  def board_reveal(guessed_pos)
    self[guessed_pos].card_reveal
    self.render
    self[guessed_pos].face_val
  end

  def board_hide(pos)
    self[pos].hide
  end

  def won?
    @size.times do |row|
      @size.times do |col|
        return false if self[[row,col]].face_down == true
      end
    end
  end

  private
  def fill_grid(size, card_values)
    @size.times do |row|
      @size.times do |col|
        curr_val = card_values.sample
        self[[row, col]] = Card.new(curr_val)
        card_values.slice!(card_values.index(curr_val))
      end
    end
  end
end
