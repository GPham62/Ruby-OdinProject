class Player
  attr_accessor :guess, :name

  def initialize(name)
    @name = name
    @guess = ""
  end

  def guess_code(guess)
    @guess = guess
  end

end