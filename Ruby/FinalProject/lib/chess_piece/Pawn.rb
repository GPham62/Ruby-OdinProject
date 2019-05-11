require_relative "ChessPiece"
class Pawn < ChessPiece
  attr_accessor :moved
  attr_reader :icon
  def initialize(color, pos)
    super
    @movement_offsets = gen_offset
    @icon = set_icon
    @moved = false
  end

  def gen_offset
    if @color == "white"
      return [[0, 1], [1, 1], [-1, 1]]
    elsif @color == "black"
      return [[0, -1], [-1, -1], [1, -1]]
    end
  end

  def set_icon
    return @color == "black"? "\u265F" : "\u2659"
  end

  def gen_moves(board)
    moves = []
    @movement_offsets.each_with_index do |offset, i|
      next_col = @coords[0] + offset[0]
      next_row = @coords[1] + offset[1]
      next if board.out_of_bounds?(next_col, next_row)
      if i == 0
        next if board.state["row #{next_row}"][next_col]
        moves.push([next_col, next_row])
        next if @moved
        next_col += offset[0]
        next_row += offset[1]
        moves.push([next_col, next_row]) unless board.state["row #{next_row}"][next_col]
      else
        if board.state["row #{next_row}"][next_col] && board.state["row #{next_row}"][next_col].color != @color
          moves.push([next_col, next_row])
        end
      end
    end
    moves
  end 
end