# Represents the board in a game of chess. Uses a two-dimensional array to store
# the state of the board, where elements in each array are either empty(nil) or
# occupied by a ChessPiece object.

class ChessBoard
  LINE_BTN_INTERSECTIONS = "\u2500\u2500\u2500".freeze
  attr_accessor :state
  def initialize
    @state = [[nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil]]
  end

  # Display the state of the board
  def to_s
    file_labels = "    a   b   c   d   e   f   g   h  \n\n"
    draw_top_board_edge
    8.downto(1).each do |rank|
      print rank.to_s
      draw_middle_of_rank(rank)
      draw_bottom_of_rank unless rank == 1
    end
    draw_bottom_board_edge
    print file_labels
  end

  def convert_coords_to_arr_idxs(coords)
    arr_idxs = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    file, rank = coords
    file = arr_idxs[file.to_sym]
    rank = Integer(rank) - 1
    [file, rank]
  end

  def out_of_bounds?(file, rank)
    (file > 7 || file < 0) || (rank > 7 || rank < 0)
  end

  def move_piece(file, rank, new_file, new_rank)
    piece = @state[file][rank]
    @state[new_file][new_rank] = piece
    piece.coords = [new_file, new_rank]
    @state[file][rank] = nil
  end

  # Visit each space on the board and use the element in that space, a provided
  # collection, and the board to accomplish something given in a block.
  def traverse(collection)
    @state.each do |arr|
      arr.each do |ele|
        yield(ele, collection, self)
      end
    end
    collection
  end

  private

  def draw_top_board_edge
    top_edge_shapes = {left_crnr: "  \u250C", intersection: "\u252C", right_crnr: "\u2510"}
    top_edge = top_edge_shapes[:left_crnr]
    8.times do |idx|
      top_edge += LINE_BTN_INTERSECTIONS
      top_edge += top_edge_shapes[:intersection] unless idx == 7
    end
    top_edge += top_edge_shapes[:right_crnr]
    puts top_edge
  end

  def draw_middle_of_rank(rank)
    middle_of_rank = ' '
    9.times do |file|
      space = @state[file][rank - 1] unless file > 7
      space_represenation = ' '
      if space.is_a?(String)
        space_represenation = space
      elsif space
        space_represenation = space.representation
      end
      middle_of_rank_shapes = { edge_of_space: "\u2502", inside_of_space: " #{space_represenation} " }
      middle_of_rank += middle_of_rank_shapes[:edge_of_space]
      middle_of_rank += middle_of_rank_shapes[:inside_of_space] unless file == 8
    end
    puts middle_of_rank
  end

  def draw_bottom_of_rank
    rank_bottom_edge_shapes = { rank_bottom_left_edge: "  \u251C", rank_bottom_intersection: "\u253C", rank_bottom_right_edge: "\u2524" }
    rank_bottom_edge = rank_bottom_edge_shapes[:rank_bottom_left_edge]
    8.times do |idx|
      rank_bottom_edge += LINE_BTN_INTERSECTIONS
      rank_bottom_edge += rank_bottom_edge_shapes[:rank_bottom_intersection] unless idx == 7
    end
    rank_bottom_edge += rank_bottom_edge_shapes[:rank_bottom_right_edge]
    puts rank_bottom_edge
  end

  def draw_bottom_board_edge
    bottom_edge_shapes = { bottom_left_corner: "  \u2514", bottom_intersection: "\u2534", bottom_right_corner: "\u2518" }
    bottom_edge = bottom_edge_shapes[:bottom_left_corner]
    8.times do |idx|
      bottom_edge += LINE_BTN_INTERSECTIONS
      bottom_edge += bottom_edge_shapes[:bottom_intersection] unless idx == 7
    end
    bottom_edge += bottom_edge_shapes [:bottom_right_corner]
    puts bottom_edge
  end
end
