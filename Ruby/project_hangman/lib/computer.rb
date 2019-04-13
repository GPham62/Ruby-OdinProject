require 'csv'

class Computer
  attr_accessor :code
  def initialize
    @dictionary = CSV.open '../dictionary.csv'
    @code = []
  end

  def get_secret_word
    secret_words = []
    @dictionary.each do |line|
      if line[0].length >= 5 && line[0].length <= 12
        line[0].gsub!("\n", "")
        secret_words.push(line[0].downcase)
      end
    end
    @code = secret_words[rand(secret_words.length)].split("")
  end

  def correct_letter?(guess)
    @code.include?(guess)
  end

  def find_letter(guess)
    correct_letters = {}
   @code.each_with_index do |val, i|
      if guess == val
      correct_letters[i] = val
      end
    end
    correct_letters
  end
end
