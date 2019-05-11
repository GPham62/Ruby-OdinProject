require_relative 'chess_piece'
class Queen < ChessPiece
  def initialize(color, coords = nil)
    super(color, :queen, coords)
  end

  def gen_moves(board)
    super(board)
  end
end
