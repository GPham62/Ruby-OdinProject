class ChessPiece
  attr_reader :color, :icon, :movement_offsets
  attr_accessor :coords

  def initialize(color = nil, pos = nil)
    @color = color
    @coords = pos
    @icon = nil
  end

  def gen_moves(board)
    moves = []
    @movement_offsets.each do |offset|
      gen_move_one_dir(@coords, offset, board, moves)
    end
    moves
  end

  def gen_move_one_dir(coords, offset, board, moves)
    next_col = @coords[0] + offset[0]
    next_row = @coords[1] + offset[1]
    return if board.out_of_bounds?(next_col, next_row)
    if board.state["row #{next_row}"][next_col]
      moves.push([next_col, next_row]) unless board.state["row #{next_row}"][next_col].color == @color
      return
    end
    moves.push([next_col, next_row])
    gen_move_one_dir([next_col, next_row], offset, board, moves)
  end 
end
