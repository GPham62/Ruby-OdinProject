require_relative "Gameplay"
require 'pry'
def startGame
  game = Gameplay.new
  print "Player 1 name?: "
  game.player1 = Player.new(gets.chomp.to_s, "white")
  print "Player 2 name?: "
  game.player2 = Player.new(gets.chomp.to_s, "black")
  print "Player #{game.player1.name} haves #{game.player1.color} pieces, "
  print " player #{game.player2.name} haves #{game.player2.color} pieces.\n" 
  game.set_up_board
  game.current_player = game.player1
  run(game)
end

def run(game)
  game.board.display
  puts "Turn #{game.turn}, #{game.current_player.name.capitalize}'s turn."
  run(play_turn(game))
end

def play_turn(game)
  if game.check_mate?
    puts "Checkmate, #{game.player.name.capitalize}, you lose!"
    startGame
  end
  game.move_a_piece
  game.turn += 1 if game.current_player.color == "black"
  game.switch_players
  return game
end

startGame