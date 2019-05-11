# Contains the attributes and methods that chess pieces have in common. 
# It is intended to the parent class to King, Queen, etc. gen_moves() is
# overwritten where necessary.

class ChessPiece
  attr_reader :color, :representation, :movement_offsets
  attr_accessor :coords
  def initialize(color, type, coords)
    @color = color
    @representation = get_representation(color, type)
    @coords = coords
    @movement_offsets = get_offsets(type)
  end

  def gen_moves(board)
    moves = []
    @movement_offsets.each do |offset|
      gen_moves_in_one_dir(@coords, offset, board, moves)
    end
    moves
  end

  private

  def get_representation(color, type)
    {white: {king: "\u265A", queen: "\u265B", rook: "\u265C",
             bishop: "\u265D", knight: "\u265E", pawn:"\u265F"},
     black: {king: "\u2654", queen: "\u2655", rook: "\u2656",
             bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}}[color][type]
  end

  def get_offsets(type)
    offsets = [[0, 1], [1, 1], [1, 0], [1, -1], 
               [0, -1], [-1, -1], [-1, 0], [-1, 1]]
    {king:    offsets, queen: offsets,
     bishop: [offsets[1], offsets[3],
              offsets[5], offsets[7]],
     rook:   [offsets[0], offsets[2],
              offsets[4], offsets[6]],
     knight: [[1,   2], [2,   1], [2, -1], [1, -2],
              [-1, -2], [-2, -1], [-2, 1], [-1, 2]],
     pawn: {white: [offsets[0], offsets[1], offsets[7]],
            black: [offsets[4], offsets[3], offsets[5]]}}[type]
  end

  def gen_moves_in_one_dir(coords, offset, board, moves)
    file = coords[0] + offset[0]
    rank = coords[1] + offset[1]
    return if board.out_of_bounds?(file, rank)
      
    if board.state[file][rank]
      moves.push([file, rank]) unless board.state[file][rank].color == @color
      return
    end

    moves.push([file, rank])
    gen_moves_in_one_dir([file, rank], offset, board, moves)
  end
end

