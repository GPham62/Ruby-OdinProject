require './player.rb'
require './breaker.rb'
require './coder.rb'
require './board.rb'
require 'pry'


class Menu

  def initialize
    @board = Board.new
    @round = 0 #12rounds max
    @colors = ["red", "blue", "green", "yellow", "white", "purple"]
  end

  def startGame
    intro
    print "What's your name: "
    player_name = gets.chomp.downcase.capitalize
    print 'Choose your side("b" for breaker and "c" for coder): '
    type = gets.chomp
    if type == "b"
      @coder = Coder.new("Computer")
      @breaker = Breaker.new(player_name)
      play
    elsif type == "c"
      @breaker = Breaker.new("Computer")
      @coder = Coder.new(player_name)
      play
    else puts "Wrong side input"
    end
  end

  def play
    if @coder.name == "Computer"
      @coder.code.each_with_index do |val, i|
        @coder.code[i] = @colors[rand(6)]
      end
      # print @coder.code
      # puts ""
      while @round <= 11
        @round += 1
        puts "Round #{@round}: From these colors #{@colors.join("  ").upcase()}\nPick your guess:"
        @breaker.guessCode
        if @coder.isWin?(@breaker.guess)
          puts "You WIN"
          break
        else
          @board.addToBoard(@coder.howClose(@breaker.guess), @breaker.guess, @round)
          @board.render
        end
      end
      unless @coder.defeated
        puts "HAHA LOSER!!"
      end
    elsif @breaker.name == "Computer"
      @coder.getCode
      while @round <= 11
        @round += 1
        puts "THE COMPUTER IS THINKING........."
        sleep(1)
        if @round == 1
          @breaker.guessCodeComputer(@colors)
        else
          @breaker.guessSmartComputer(@colors, @coder.howClose(@breaker.guess), @coder.code)
        end
        if @coder.isWin?(@breaker.guess)
          puts "Computer outsmarted you!"
          break
        else
          @board.addToBoard(@coder.howClose(@breaker.guess), @breaker.guess, @round)
          @board.render
        end
      end
      unless @coder.defeated
        puts "Computer lose!!"
      end
    else raise "Something went wrong..."    
    end
  end

  def intro
    print "Welcome to the mastermind game!\n"
    print "breaker have to guess what coder is choosing as a 4 winning colors\n"
  end
end