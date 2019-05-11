# Contains the attributes and methods necessary to maintain the status of a 
# chess game.

require_relative './chess_pieces/chess_piece'

require_relative './chess_pieces/king'
require_relative './chess_pieces/queen'
require_relative './chess_pieces/bishop'
require_relative './chess_pieces/rook'
require_relative './chess_pieces/knight'
require_relative './chess_pieces/pawn'

require_relative 'chess_board'

class ChessGame
  attr_accessor :turn
  attr_reader :player, :board
  
  def initialize
    @board = ChessBoard.new
    @player = :white
    @turn = 1
  end
  
  def set_up_board
    set_up_info = {king:    {white: [[4, 0]],         black: [[4, 7]]},
                    queen:  {white: [[3, 0]],         black: [[3, 7]]},
                    bishop: {white: [[2, 0], [5, 0]], black: [[2, 7], [5, 7]]},
                    rook:   {white: [[0, 0], [7, 0]], black: [[0, 7], [7, 7]]},
                    knight: {white: [[1, 0], [6, 0]], black: [[1, 7], [6, 7]]},
                    pawn:   {white: [[0, 1], [1, 1], [2, 1], [3, 1], 
                                     [4, 1], [5, 1], [6, 1], [7, 1]],
                             black: [[0, 6], [1, 6], [2, 6], [3, 6],
                                     [4, 6], [5, 6], [6, 6], [7, 6]]}}
    set_up_info.each do |piece, set_up_data|
      set_up_data.each do |color, starting_positions|
        starting_positions.each do |pos|
          file, rank = pos
          @board.state[file][rank] = eval(piece.to_s.capitalize).new(color, pos)
        end
      end
    end

    return nil
  end
  
  def choose_a_piece_to_move
    chosen_coords = gets.downcase.strip.split(//)
    begin
      raise ("Invalid input, try again. ") unless valid?(chosen_coords)
      file, rank = @board.convert_coords_to_arr_idxs(chosen_coords)
      chosen_piece = @board.state[file][rank]
      raise ("No chess piece at the selected coordinates. ") unless chosen_piece
      raise ("Not your piece to move. ") unless chosen_piece.color == @player
      legal_moves = legal_moves(chosen_piece)
      raise ("That piece cannot move. ") unless legal_moves.any?
      return [file, rank, legal_moves]
    rescue RuntimeError => exception
      print exception.message
    end
    choose_a_piece_to_move
  end
  
  def display_moves(moves)
    serialized_board = Marshal.dump(@board)
    temp_board = Marshal.load(serialized_board)
    moves.each do |move|
      file, rank = move
      next if temp_board.state[file][rank].is_a?(King)
      temp_board.state[file][rank] = 'X'
    end
    temp_board.to_s
  end
  
  def choose_move(moves)
    chosen_move = gets.downcase.strip.split(//)
    begin
      raise ('Invalid input, try again. ') unless valid?(chosen_move)
      file, rank = @board.convert_coords_to_arr_idxs(chosen_move) 
      if moves.include?([file, rank]) && !@board.state[file][rank].is_a?(King)
        return [file, rank]
      end
      raise ('The move you chose is invalid, try again. ')           
    rescue RuntimeError => exception
      print exception.message
    end
    choose_move(moves)
  end
  
  def move_a_piece
    print "Which piece would you like to move? "
    file, rank, possible_moves = choose_a_piece_to_move
    piece = @board.state[file][rank]
    display_moves(possible_moves)
    print "Which move would you like to make? "
    new_fle, new_rnk = choose_move(possible_moves)
    @board.move_piece(file, rank, new_fle, new_rnk)
    piece = promotion if (new_rnk == 7 || new_rnk == 0) && piece.is_a?(Pawn)
    @board.state[new_fle][new_rnk] = piece
    piece.coords = [new_fle, new_rnk]
    if piece.is_a?(Pawn) || piece.is_a?(King) || piece.is_a?(Rook)
      piece.moved = true
    end
  end
      
  def switch_players
      if @player == :white
          @player = :black
      else
          @player = :white
      end
  end
  
  def check_mate?
    @board.traverse({}) do |piece, moves, board|
      moves[piece] = legal_moves(piece) if piece && piece.color == @player
    end.values.all? {|moves| moves.empty?}
  end
  
  private
  
  def valid?(input)
      input.length == 2 && /[a-h]/.match?(input[0]) && /[1-8]/.match?(input[1])
  end
  
  # Determines the legal moves that a given chess piece can make.

  # All of the possible moves for a given piece are generated and evaluated 
  # one at a time on a deep-copy of the current board. After a move is made on
  # the copied board, the possible moves for every one of the opponents' chess
  # pieces are generated and checked for the presence of a king. 
  
  # The hypothetical move is removed from the list of possible moves if a king
  # is found. The presence of a king indicates the move would place the king in
  # check if made.  

  def legal_moves(piece)
    moves = piece.gen_moves(@board)
    file, rank = piece.coords
    moves.delete_if do |tmp_file, tmp_rank|
      temp_board = Marshal.load(Marshal.dump(@board))
      temp_board.move_piece(file, rank, tmp_file, tmp_rank)
      oppnent_moves = temp_board.traverse([]) do |ele, moves, board|
        moves.push(ele.gen_moves(board)) if ele && ele.color != @player
      end.flatten!(1).uniq!

      oppnent_moves.any? {|file, rank| temp_board.state[file][rank].is_a?(King)}
    end
    moves
  end 

  def promotion
    print "(Q)ueen, (K)night, (R)ook, or (B)ishop? "
    selection = gets.downcase.strip
    begin
      raise('Invalid selection, try again. ') unless /[qkrb]/.match?(selection)
      case selection
      when 'q' then selection = Queen.new(@player)
      when 'k' then selection = Knight.new(@player)
      when 'r' then selection = Rook.new(@player)
      when 'b' then selection = Bishop.new(@player)
      end
      return selection
    rescue RuntimeError => exception
      print exception.message
    end
    promotion
  end
end