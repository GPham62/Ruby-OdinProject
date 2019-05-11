require_relative 'position'
class Board
  attr_accessor :visited, :vertices, :adjacent_vertices
  def initialize
    @visited = Array.new(64, false)
    @vertices = []
    generate_vertices
    generate_adjacent_vertices
  end

  def get_vertex(pos)
    @vertices.each do |vertex|
      return vertex if vertex.position == pos
    end
  end

  def get_vertex_index(pos)
    @vertices.each_with_index do |vertex, i|
      return i if vertex.position == pos
    end
  end

  def generate_vertices
    (0..7).each do |i|
      (0..7).each do |j|
        @vertices.push(Position.new(i, j))
      end
    end
  end

  def valid_pos?(x, y)
    return false if (x < 0 || x > 7) || (y < 0 || y > 7)
    true
  end

  def verify_movement(vertex)
    vertex_x, vertex_y = vertex.position
    knight_moveset = [[-2, -1], [-2, 1], [-1, 2], [-1, -2], [1, 2], [1, -2], [2, -1], [2, 1]]
    adjacent_vertex_list = []
    knight_moveset.each do |move|
      adjacent_x = vertex_x + move[0]
      adjacent_y = vertex_y + move[1]
      adjacent_vertex_list << [adjacent_x, adjacent_y] if valid_pos?(adjacent_x, adjacent_y)
    end
    adjacent_vertex_list
  end

  def generate_adjacent_vertices
    @vertices.each do |vertex|
      adjacent_vertex_list = verify_movement(vertex)
      adjacent_vertex_list.each do |coord|
        vertex.adjacent_vertices << get_vertex(coord)
      end
    end
  end
end