require './BoardGame.rb'
require './Player.rb'

class Menu
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @gameboard = BoardGame.new
    @turn = 1
    @winPatterns = [
                    [00,10,20], [01,11,21], [02,12,22],
                    [00,01,02], [10,11,12], [20,21,22],
                    [00,11,22], [20,11,02]
                  ]
  end

  def startGame
    until (winner? || @gameboard.isFullBoard?)
     @turn == 1? play(@player1) : play(@player2)
     @turn = @turn == 1? 0 : 1 
    end
    endGame
  end

  def play(player)
    loop do
      @gameboard.renderBoard
      choice = player.getChoice(@gameboard)
      if choice
        puts "Your choice is: #{choice[0]} #{choice[1]}"
        @gameboard.fill(choice[0], choice[1], player.character)
        choice = choice[0].to_s + choice[1].to_s
        player.history.push(choice.to_i)
        player.history = player.history.sort
        break
      end
    end
  end

  def winner?
    players = [@player1, @player2]
    players.each do |player|
      @winPatterns.each do |winPattern|
        winPattern = winPattern.sort
        puts "#{player.name}'s win pattern: #{winPattern}"
        return player.name if player.isWin?(winPattern)
      end
    end
    false
  end

  def endGame
    if winner?
      @gameboard.renderBoard
      puts "Congratz #{winner?} you are the winner!"
    elsif @gameboard.isFullBoard?
      @gameboard.renderBoard
      puts "It's a tie!"
    end
  end
end

