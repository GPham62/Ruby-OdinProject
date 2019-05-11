require_relative "ChessPiece"
class Bishop < ChessPiece
  attr_reader :icon
  def initialize(color, pos)
    super
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1]] 
    @icon = set_icon
  end

  def set_icon
    return @color == "black"? "\u265D" : "\u2657"
  end

  def gen_moves(board)
    super(board)
  end
end