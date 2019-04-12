class Coder < Player
  attr_accessor :name, :code
  attr_reader :defeated

  def initialize(name)
    super(name)
    @code = ["", "", "", ""]
    @defeated = false
  end

  def getCode
    puts "Enter your code:"
    your_code = gets.chomp.downcase.split(" ")
    if your_code.length == 4
      @code = your_code
    else raise "error code"
    end
  end

  def isWin?(guess)
    @defeated = true if answer = @code == guess
    answer
  end

  def howClose(guess)
    right_spot = 0
    right_color = 0
    guess.each_with_index do |val, i|
      right_spot += 1 if guess[i] == @code[i]
    end
    guess.each do |guess_color|
      right_color += 1 if @code.any?(guess_color) 
    end

    answer = {
      "correct_spot" => right_spot,
      "correct_color" => right_color
    }
    answer
  end
end
