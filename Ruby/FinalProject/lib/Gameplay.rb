require_relative './chess_piece/ChessPiece.rb'
require_relative './chess_piece/Knight.rb'
require_relative './chess_piece/Bishop.rb'
require_relative './chess_piece/King.rb'
require_relative './chess_piece/Pawn.rb'
require_relative './chess_piece/Queen.rb'
require_relative './chess_piece/Rook.rb'
require_relative './player/Player.rb'
require_relative 'Board.rb'
require 'pry'

class Gameplay
  attr_accessor :board, :turn, :player1, :player2, :current_player
  def initialize
    @board = Board.new
    @turn = 1 
  end

  def set_up_board
    piece_pos = {
      rook: {
        white: [[0, 0], [7, 0]],
        black: [[0, 7], [7, 7]]
      },
      knight: {
        white: [[1, 0], [6, 0]],
        black: [[1, 7], [6, 7]]
      },
      bishop: {
        white: [[2, 0], [5, 0]],
        black: [[2, 7], [5, 7]]
      },
      queen: {
        white: [[3, 0]],
        black: [[3, 7]]
      },
      king: {
        white: [[4, 0]],
        black: [[4, 7]]
      },
      pawn: {
        white: [[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1]],
        black: [[0, 6], [1, 6], [2, 6], [3, 6], [4, 6], [5, 6], [6, 6], [7, 6]]
      }
    }


    piece_pos.each do |piece, piece_data|
      piece_data.each do |color, starting_pos|
        starting_pos.each do |pos|
          col, row = pos
          @board.state["row #{row}"][col] = eval(piece.to_s.capitalize).new(color.to_s, pos)

        end
      end
    end
  end

  def move_a_piece
    print "Which piece would you like to move?: "
    col, row, legal_moves = choose_piece
    piece = @board.state["row #{row}"][col]
    display_moves(legal_moves)
    print "Which move would you make: "
    new_col, new_row = choose_move(legal_moves)
    @board.move_piece(col, row, new_col, new_row)
    piece = Queen.new(@color, chosen_piece.coords) if (new_row == 7 || new_row == 0) && piece_data.is_a?(Pawn)
    @board.state["row #{new_row}"][new_col] = piece
    piece.coords = [new_row, new_col]
    if piece.is_a?(Pawn) || piece.is_a?(King) || piece.is_a?(Rook)
      piece.moved = true
    end
  end

  def choose_move(legal_moves)
    chosen_move = gets.chomp.downcase.split(//)
    chosen_move.delete(" ")
    begin
      raise ("Invalid input, try again. ") unless valid?(chosen_move)
      col, row = @board.convert_coords_to_index(chosen_move)

      if legal_moves.include?([col, row]) && !@board.state["row #{row}"][col].is_a?(King)
        return [col, row]
      end
      raise ("The move you choose is invalid, try again. ")
    rescue RuntimeError => exception
      print exception.message
    end
    choose_move(legal_moves)
  end

  def display_moves(legal_moves)
    temp_board = Marshal.load(Marshal.dump(@board))
    legal_moves.each do |move|
      col, row = move
      next if temp_board.state["row #{row}"][col].is_a?(King)
      temp_board.state["row #{row}"][col] = 'X'
    end
    temp_board.display
  end

   def choose_piece
    chosen_coords = gets.chomp.downcase.split(//)
    chosen_coords.delete(" ")
    begin
      raise("Invalid input, try again. ") unless valid?(chosen_coords)
      col, row = @board.convert_coords_to_index(chosen_coords)
      chosen_piece = @board.state["row #{row}"][col]
      raise ("No chess piece at the selected coord.") unless chosen_piece
      raise ("Not your piece to move.") unless chosen_piece.color == @current_player.color
      legal_moves = legal_moves(chosen_piece)
      raise ("That piece cannot move.") unless legal_moves.any?
      return [col, row, legal_moves]
    rescue RuntimeError => exception
      print exception.message
    end
    choose_piece
  end

  def legal_moves(chosen_piece)
    moves = chosen_piece.gen_moves(@board)
    col, row = chosen_piece.coords
    moves.delete_if do |temp_col, temp_row|
      temp_board = Marshal.load(Marshal.dump(@board))
      temp_board.move_piece(col, row, temp_col, temp_row)
      opponent_moves = []
      temp_board.state.each do |row, value|
        value.each do |piece|
          opponent_moves.push(piece.gen_moves(temp_board)) if piece && piece.color != @current_player.color
        end
      end
      opponent_moves = opponent_moves.flatten!(1).uniq!
      opponent_moves.any?{|col, row| temp_board.state["row #{row}"][col].is_a?(King)}
    end
    moves
  end

  def valid?(chosen_coords)
    chosen_coords.length == 2 && /[a-h]/.match?(chosen_coords[0]) && /[1-8]/.match?(chosen_coords[1])
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else @current_player = @player1
    end
  end

  def check_mate?
    moves = []
    @board.state.each do |row, value|
      value.each do |piece|
        moves.push(piece.gen_moves(@board)) if piece && piece.color == @current_player.color
      end
    end
    moves.all?{|moves| moves.empty?}
  end 
end 
