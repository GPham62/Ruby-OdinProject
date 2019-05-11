class Board
  LINE = "\u2500\u2500\u2500"
  attr_accessor :state
  def initialize
    @state = gen_state
    @arr_idx = { a:0, b:1, c:2, d:3, e:4, f:5, g:6, h:7}
  end

  def gen_state
    table = {}
    (0..7).each do |i|
      table["row #{i}"] = []
      8.times do |j|
        table["row #{i}"].push(nil)
      end
    end
    table
  end

  def display
    draw_top_board
    draw_middle_board
    draw_bottom_board
    space = "   "
    print " "
    @arr_idx.each do |key, value|
      print space + key.to_s
    end
    print "\n\n"
  end

  def draw_middle_board
    edge = "\u2502"
    8.downto(1) do |row|
      print row.to_s
      middle_row = " " + edge
      8.times do |col|
        space = @state["row #{row-1}"][col]
        middle_row += " "
        if space
          middle_row += space.is_a?(String) ? space.to_s : space.icon
        else
          middle_row += " "
        end
        middle_row += " " + edge
      end
      puts middle_row
      bottom_left_edge = "\u251C"
      bottom_right_edge = "\u2524"
      row_intersection = "\u253C"
      bottom_row = "  " + bottom_left_edge
      8.times do |i|
        bottom_row += LINE
        bottom_row += row_intersection unless i == 7
      end
      bottom_row += bottom_right_edge
      puts bottom_row unless row == 1
    end
  end

  def draw_top_board
    top_left_corner = "\u250C"
    top_right_corner = "\u2510"
    intersection = "\u252C"
    top_edge = "  " + top_left_corner
    8.times do |i|
      top_edge += LINE
      top_edge += intersection unless i == 7
    end
    top_edge += top_right_corner
    puts top_edge
  end

  def draw_bottom_board
    bottom_left_corner = "\u2514"
    bottom_right_corner = "\u2518"
    intersection = "\u2534"
    bottom_edge = "  " + bottom_left_corner
    8.times do |i|
      bottom_edge += LINE
      bottom_edge += intersection unless i == 7
    end
    bottom_edge += bottom_right_corner
    puts bottom_edge
  end

  def convert_coords_to_index(chosen_coords)
    col = @arr_idx[chosen_coords[0].to_sym]
    row = chosen_coords[1].to_i - 1
    return [col, row]
  end

  def out_of_bounds?(next_col, next_row)
    next_col > 7 || next_col < 0 || next_row > 7 || next_row < 0
  end

  def move_piece(col, row, next_col, next_row)
    piece = @state["row #{row}"][col]
    @state["row #{next_row}"][next_col] = piece
    piece.coords = [next_col, next_row]
    @state["row #{row}"][col] = nil
  end
end

