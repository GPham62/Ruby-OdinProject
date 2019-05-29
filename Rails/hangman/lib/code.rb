
class Hangman
  attr_accessor :progress, :code, :chance, :incorrect_letters, :message
  def initialize
    @dictionary = File.readlines(File.expand_path('../dictionary.txt', __dir__))
    get_secret_from_dict
    @code = @secrets[rand(@secrets.length)].split("")
    @progress = hide_secret
    @chance = 10
    @incorrect_letters = []
    @message = ["Welcome to the game!", "#0066ff"]
  end

  def get_secret_from_dict
    @secrets = []
    @dictionary.each do |line|
      if line.length >=6 && line.length <= 13
        line.gsub!("\n", "")
        @secrets.push(line.downcase)
      end
    end
  end

  def hide_secret
    hide = []
    @code.length.times do
      hide.push('_')
    end
    hide.join(" ")
  end

  def guess_letter(guess)
    if @chance > 1
      @chance -= 1
      if @code.include?(guess)
        idx = @code.index(guess)
        @progress[idx] = guess
        if @progress == @code
          annouce_winner
        else
          @message = ["Correct letter!", "#66ff33"]
        end
      else
        @incorrect_letters << guess
        @message = ["Wrong letter!", '#ff6600']
      end
    else
      if @progress == @code
        annouce_winner
      else
        annouce_loser
      end
    end
  end

  def annouce_winner
    @message = ["You Won!", "#66ff33"]
    @code = @secrets[rand(@secrets.length)].split("")
    @progress = hide_secret
    @chance = 10
    @incorrect_letters = []
  end

  def annouce_loser
    @message = ["You Lose!", '#ff6600']
    @code = @secrets[rand(@secrets.length)].split("")
    @progress = hide_secret
    @chance = 10
    @incorrect_letters = []
  end
end
