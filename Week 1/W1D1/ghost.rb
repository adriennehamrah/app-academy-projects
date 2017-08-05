class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @fragment = ""
    @dictionary = File.readlines("dictionary.txt").map { |w| w.chomp}
  end

  def play_round

    @cur_player = @player1
    @prev_player = @player2
    take_turn(@cur_player)
    next_player!
  end

  def next_player!
    @cur_player, @prev_player = @prev_player, @cur_player
  end

  def take_turn(player)
    begin
      input = player.guess
      valid_play?(input)
    rescue
      puts "Invalid input. Try again"
      input = player.guess
      valid_play?(input)
    end
  end

  def valid_play?(input)
    raise if !("a".."z").to_a.include?(input.downcase)
    @fragment << input
    raise if !@dictionary.include?(@fragment) && @fragment.length > 2
  end


end

class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def guess
    puts "Type a letter. o_o"
    input = gets.chomp
    valid_play?(input)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new('Adrienne'), Player.new('Ricki'))
  game.play_round
end
