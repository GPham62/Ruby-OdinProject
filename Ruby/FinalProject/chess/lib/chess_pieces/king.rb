require_relative 'chess_piece'
class King < ChessPiece
  attr_accessor :moved
  def initialize(color, coords = nil)
    super(color, :king, coords)
    @moved = false
  end

  def gen_moves(board)
    moves = []
    @movement_offsets.each do |offset|
      file = @coords[0] + offset[0]
      rank = @coords[1] + offset[1]
      next if board.out_of_bounds?(file, rank) ||
      (board.state[file][rank] && board.state[file][rank].color == @color)
        
      moves.push([file, rank])
    end
    moves
  end
end
