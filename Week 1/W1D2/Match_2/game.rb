require_relative 'board.rb'
require_relative 'players.rb'

class Game
  def initialize(size = 4, player = ComputerPlayer.new)
    @board = Board.new(size)
    @board.populate
    @player = player
    @previous_guess = nil
    player.receive_size(size)
  end

  def play
    until @board.won?
      system('clear')
      @board.render
      guess = @player.get_guess
      make_guess(guess)
    end

    puts 'Congrats, you won!'
  end

  def make_guess(guess)
    reveal_card = @board.board_reveal(guess)
    @player.receive_reveal(guess, reveal_card)
    if @previous_guess
      if reveal_card == @board[@previous_guess]
        @player.receive_match(guess, @previous_guess)
        puts 'You found a match!'
        sleep(2)
      else
        puts 'Not a match'
        sleep(3)
        @board[guess].hide
        @board[@previous_guess].hide
      end
      @previous_guess = nil
    else
      @previous_guess = guess
    end
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new(4)
  game.play
end
