class Card
  attr_reader :face_val, :face_down

  def initialize(val)
    @face_val = val
    @face_down = true
  end

  def display
    print @face_down ? "   " : " #{@face_val.to_s} "
  end

  def hide
    @face_down = true
  end

  def card_reveal
    @face_down = false
  end

  def to_s
    @face_val.to_s
  end

  def ==(val)
    @face_val == val
  end
end
