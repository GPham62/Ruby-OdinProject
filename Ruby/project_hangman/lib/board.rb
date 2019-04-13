class Board
  attr_accessor :board, :correct_letter
  def initialize(comp)
    @round
    @correct_letter = []
    comp.code.length.times do
      @correct_letter.push("_")
    end
    @correct = false
  end

  def render()
    puts "ROUND #{@round} : Your number is #{@correct}"
    puts "#{@correct_letter.join(" ")}"
  end

  def add_to_board(computer, guess,round)
    if (computer.correct_letter?(guess))
      @correct = true
      letters = computer.find_letter(guess)
      letters.each do |val|
        @correct_letter[val[0]] = val[1]
      end
    else @correct = false
    end
    @round = round
  end
end