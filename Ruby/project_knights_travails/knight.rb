require_relative "board"
require "pry"

def breadth_first_search(board, start_pos, end_pos)
  queue = []
  edges = []
  start_vertex = board.get_vertex(start_pos)

  start_index = board.get_vertex_index(start_pos)
  queue << start_vertex
  board.visited[start_index] = true

  until queue.empty?
    current_vertex = queue.shift
    current_vertex.adjacent_vertices.each do |adjacent_vertex|
      # binding.pry
      adjacent_vertex_index = board.get_vertex_index(adjacent_vertex.position)
      next if board.visited[adjacent_vertex_index]
      edges << [current_vertex.position, adjacent_vertex.position]
      return edges if adjacent_vertex.position == end_pos
      queue << adjacent_vertex
      board.visited[adjacent_vertex_index] = true
    end
  end
end

def construct_shortest_path(searched_edges, start_pos, end_pos)
  shortest_path = []
  latest_move = searched_edges.rassoc(end_pos)
  shortest_path << latest_move
  until latest_move[0] == start_pos
    latest_move = searched_edges.rassoc(latest_move[0])
    shortest_path.prepend(latest_move)
  end

  shortest_path.flatten(1).uniq!
end

def knight_moves(start_pos, end_pos)
  board = Board.new
  search_edges = breadth_first_search(board, start_pos, end_pos)
  shortest_path = construct_shortest_path(search_edges,start_pos, end_pos)
  print shortest_path
end

knight_moves([3,3],[0,0])