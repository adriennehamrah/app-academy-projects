class HumanPlayer

  def initialize
  end

  def receive_size(size)
  end

  def get_guess
    print 'Guess a card position x,y: '
    input = gets.chomp
    guess = [input[0].to_i, input[-1].to_i]
  end

  def receive_reveal(pos, value)
  end

  def receive_match(guess, previous_guess)
  end
end

class ComputerPlayer
  def initialize
    @known_cards = {}
    @matched_cards = {}
    @previous_guess = nil
  end

  def receive_size(size)
    @size = size
  end

  def get_guess
    first_guess = true

    if first_guess
      guess = self.find_match
      return guess ? guess[0] : random_guess
    end
  end

  def receive_reveal(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(guess, previous_guess)
    @matched_cards[guess, previous_guess] = true, true
  end

  def which_guess
    previous_guess ? second_guess : first_guess
  end

  def first_guess
    known_match || random_guess
  end

  def second_guess
    match_first || random_guess
  end

  def known_match
    (pos, _) = @knowncards.find do |pos1, val1|
      @knowncards.any? do |pos2, val2|
        (val1 == val2 && pos1 != pos2) &&
        !(@matched_cards[pos1] || @matched_cards[pos2])
      end
    end
    pos
  end

  def match_first
    (pos, _) = @known_cards.find do |pos, val|
      pos != previous_guess && val == @known_cards[previous_guess] &&
        !@matched_cards[pos]
    end
    pos
  end

  def random_guess
    guess = nil

    while guess.nil? || @known_cards.include?([guess])
      guess = [rand(@size), rand(@size)]
    end

    guess
  end
end
