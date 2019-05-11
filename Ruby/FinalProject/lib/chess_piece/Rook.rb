require_relative "ChessPiece"
class Rook < ChessPiece
  attr_reader :icon
  attr_accessor :moved
  def initialize(color, pos)
    super
    @movement_offsets = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    @icon = set_icon
    @moved = false
  end

  def set_icon
    return @color == "black"? "\u265C" : "\u2656"
  end

  def gen_moves(board)
    super(board)
  end
end