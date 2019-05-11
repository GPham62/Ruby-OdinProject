require_relative 'chess_piece'
class Bishop < ChessPiece
  def initialize(color, coords = nil)
    super(color, :bishop, coords)
  end

  def gen_moves(board)
    super(board)
  end
end
