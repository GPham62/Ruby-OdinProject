puts Dir.pwd
class BoardGame
  attr_accessor :positions

  def initialize
    @positions = {
      0 => {
        0 => " ",
        1 => " ",
        2 => " "
      },
      1 => {
        0 => " ",
        1 => " ",
        2 => " "
      },
      2 => {
        0 => " ",
        1 => " ",
        2 => " "
      }
    }
  end

  def renderBoard

    puts "\t #{positions.values[0].values[0]} | #{positions.values[1].values[0]} | #{positions.values[2].values[0]} "
    puts "\t---|---|---"
    puts "\t #{positions.values[0].values[1]} | #{positions.values[1].values[1]} | #{positions.values[2].values[1]} "
    puts "\t---|---|---"
    puts "\t #{positions.values[0].values[2]} | #{positions.values[1].values[2]} | #{positions.values[2].values[2]} "
    puts ""
  end

  def fill(posX, posY, character)
    @positions[posX][posY] = character

  end

  def isFullBoard?
    pos1Full = @positions.values[0].values[0..2].all?{|x| x =~ /[a-z]/}
    pos2Full = @positions.values[1].values[0..2].all?{|x| x =~ /[a-z]/}
    pos3Full = @positions.values[2].values[0..2].all?{|x| x =~ /[a-z]/}
    pos1Full && pos2Full && pos3Full
  end

  def isPosTaken?(posX, posY)
    positions.values[posX].values[posY] == 'x' || positions.values[posX].values[posY] == 'o'
  end
end