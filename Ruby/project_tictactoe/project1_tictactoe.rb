require "./Menu.rb"
require "./Player.rb"

print "Player play with x: "
name1 = gets.chomp
player1 = Player.new(name1, 'x')
print "Player play with o: "
name2 = gets.chomp
player2 = Player.new(name2, 'o')
menu = Menu.new(player1, player2)
menu.startGame