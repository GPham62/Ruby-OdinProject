require_relative 'chess_piece'
class Pawn < ChessPiece
  attr_accessor :moved
  def initialize(color, coords = nil)
    super(color, :pawn, coords)
    @movement_offsets = @movement_offsets[color]
    @moved = false
  end

  def gen_moves(board)
    moves = []
    @movement_offsets.each_with_index do |offset, index|
      file = @coords[0] + offset[0]
      rank = @coords[1] + offset[1]
      next if board.out_of_bounds?(file, rank)

      if index == 0
        next if board.state[file][rank]

        moves.push([file, rank])
        next if @moved

        file += offset[0]
        rank += offset[1]
        moves.push([file, rank]) unless board.out_of_bounds?(file, rank) || board.state[file][rank]
      else
         if board.state[file][rank] && board.state[file][rank].color != @color
          moves.push([file, rank])
        end
      end
    end
    moves
  end
end
