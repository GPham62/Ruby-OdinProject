require_relative 'chess_piece'
class Knight < ChessPiece
  def initialize(color, coords = nil)
    super(color, :knight, coords)
  end

  def gen_moves(board)
    moves = []
    @movement_offsets.each do |offset|
      gen_move(offset, board, moves)
    end
    moves
  end

  private

  def gen_move(offset, board, moves)
    file = @coords[0] + offset[0]
    rank = @coords[1] + offset[1]
    if board.out_of_bounds?(file, rank)
      return
    elsif board.state[file][rank]
      moves.push([file, rank]) unless board.state[file][rank].color == @color
      return
    end

    moves.push([file, rank])
  end
end
