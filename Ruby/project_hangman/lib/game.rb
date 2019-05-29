require '../lib/computer.rb'
require '../lib/player.rb'
require '../lib/board.rb'
require 'pry'
require 'json'

class Game
  def initialize
    @computer = Computer.new
    @computer.get_secret_word
    @board = Board.new(@computer)
    @round = 0
  end

  def start_game
    print @computer.code
    print_intro
    puts "Our secret code have #{@computer.code.length} characters"
    until is_over?
      @round += 1
      play_round
    end
  end

  def is_over?
    if @round >= 10
      puts "YOU LOSE!!!"
      @board.render
      puts "The answer is: #{@computer.code.join("")}"
      return true
    elsif is_win?
      return true
    end
    false
  end

  def play_round
    print "Give me a letter: "
    guess = gets.chomp.to_s.downcase
    while guess.length > 1 || guess.match?(/[0-9]/)
      if guess == "save"
        save_game
        print "Give me a letter: "
        guess = gets.chomp.to_s.downcase
        break
      elsif guess == "load"
        load_game
        print "Give me a letter: "
        guess = gets.chomp.to_s.downcase
        break
      else
        print "One letter only please: "
        guess = gets.chomp.to_s.downcase
      end
    end
    @player.guess_code(guess)
    @board.add_to_board(@computer, @player.guess, @round)
    @board.render
  end

  def is_win?
    if @player.guess == @computer.code
      @board.render
      puts "YOU WIN!!!"
      true
    end
    false
  end

  def print_intro
    puts "Welcome to Hangman Game!"
    puts "You have 10 chances to guess our secret little word with 5-12 characters"
    print "What's your name?: "
    @player = Player.new(gets.chomp.downcase)
    puts "You can save the game by typing in 'save' or load your other run by typing in 'load'"
  end

  def save_game
    Dir.mkdir("../save_files/") unless Dir.exists?("../save_files/")
    puts "Do you want to name ur file?(y/n)"
    answer = gets.chomp.downcase
    if answer == "y"
      puts "Name your file: "
      f_name = gets.chomp.split(" ").join("_").to_s
      filename = "../save_files/#{f_name}_#{Time.new.usec}.json"
    else filename = "../save_files/#{@player.name.split(" ").join("_").to_s}_#{Time.new.usec}.json"
    end

    data = {
      secret_code: @computer.code,
      correct_letter: @board.correct_letter,
      player_name: @player.name,
      round: @round
    }

    File.open(filename, "w+") do |file|
      file.puts data.to_json
    end

    puts "File #{filename} SAVED!!"

    exit
  end

  def load_game
    save_file = Dir.open("../save_files/")
    puts "Current saves:"
    Dir.foreach(save_file){|file| puts "  #{file.split(".")[0]}"}
    puts "Which file would you like to load?"
    previous_save = gets.chomp.split(" ").join("_").to_s

    if File.exists?("../save_files/#{previous_save}.json")
      file = File.read("../save_files/#{previous_save}.json")
      data = JSON.parse(file)
      puts data
      @computer.code = data["secret_code"]
      @board.correct_letter = data["correct_letter"]
      @player.name = data["player_name"]
      @round = data["round"]
      puts "Previous save loaded!!"
    else
      puts "FILE DOESN'T EXIST!!"
      load_game
    end
  end
end

game = Game.new
game.start_game