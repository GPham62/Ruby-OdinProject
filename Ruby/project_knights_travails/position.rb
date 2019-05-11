class Position
  attr_accessor :position, :adjacent_vertices
  def initialize(x, y)
    @position = [x, y]
    @adjacent_vertices = []
  end
end