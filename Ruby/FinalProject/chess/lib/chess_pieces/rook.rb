require_relative 'chess_piece'
class Rook < ChessPiece
  attr_accessor :moved
  def initialize(color, coords = nil)
    super(color, :rook, coords)
    @moved = false
  end

  def gen_moves(board)
    super(board)
  end
end
