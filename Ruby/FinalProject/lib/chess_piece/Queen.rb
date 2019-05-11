require_relative "ChessPiece"
class Queen < ChessPiece
  attr_reader :icon
  def initialize(color, pos)
    super
    @movement_offsets = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    @icon = set_icon
  end

  def set_icon
    return @color == "black"? "\u265A" : "\u2655"
  end

  def gen_moves(board)
    super(board)
  end
end