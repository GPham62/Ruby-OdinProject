class Breaker < Player
  attr_accessor :name, :guess
  def initialize(name)
    super(name)
    @guess = ["", "", "", ""]
  end

  def guessCode
    your_guess = gets.chomp.downcase.split(" ")
    if your_guess.length == 4
      @guess = your_guess
    else raise "error guess"
    end
  end

  def guessCodeComputer(colors)
    binding.pry
    @guess.each_with_index do |element, i|
        @guess[i] = colors[rand(6)]
    end
    binding.pry
  end

  def guessSmartComputer(colors, howClose, code)
    if howClose["correct_color"] > 0
      correct_colors = []
      correct_colors = @guess & code
      until correct_colors.length == 4
        correct_colors.push(colors[rand(6)])
      end
      @guess = correct_colors.shuffle
    else
      guessCodeComputer(colors)
    end
  end

end

  