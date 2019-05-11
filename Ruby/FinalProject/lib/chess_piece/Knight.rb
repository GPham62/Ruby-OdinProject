require_relative "ChessPiece"
class Knight < ChessPiece
  attr_reader :icon
  def initialize(color, pos)
    super
    @movement_offsets = [[2, 1], [2, -1], [-2, -1], [-2, 1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    @icon = set_icon
  end

  def set_icon
    return @color == "black"? "\u265E" : "\u2658"
  end

 def gen_moves(board)
    moves = []
    @movement_offsets.each do |offset|
      next_col = @coords[0] + offset[0]
      next_row = @coords[1] + offset[1]
      next if board.out_of_bounds?(next_col, next_row) || (board.state["row #{next_row}"][next_col] && board.state["row #{next_row}"][next_col].color == @color)
      moves.push([next_col, next_row])
    end
    moves
  end
end