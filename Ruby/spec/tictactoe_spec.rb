require './project_tictactoe/Menu.rb'
require './project_tictactoe/Player.rb'
require './project_tictactoe/BoardGame.rb'

describe 'TicTacToe' do
  before(:each) do
    @player1 = Player.new("player1", 'x')
    @player2 = Player.new("player2", 'o')
    @menu = Menu.new
  end
end
