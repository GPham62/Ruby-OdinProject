class Player
  attr_accessor :positions, :name, :character, :history

  def initialize(name, character)
    @name = name
    @character = character
    @history = []
  end

  def getChoice(gameBoard)
    puts "#{@name} select ur next move(Enter position x and y seperated by a space): "
    position = gets.chomp.split(" ")
    posX = position[0].to_i
    posY = position[1].to_i
    position = [posX, posY]
    if (0..2).include?(posX) && (0..2).include?(posY)
      gameBoard.isPosTaken?(posX, posY) ? puts("That spot is already taken, try again! \n") : position
    else
      puts "Enter correct position please !"
    end
  end

  def isWin?(winPattern)
    winPattern && (winPattern - @history).empty?
  end
end