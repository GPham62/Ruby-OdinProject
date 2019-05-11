require File.expand_path('../../lib/chess_pieces/pawn.rb', __dir__)
require File.expand_path('../../lib/chess_game.rb', __dir__)

describe Pawn do
  describe '#initialize' do
    context 'when pawn is white' do
      before(:each) do
        @pawn = Pawn.new(:white)
      end

      it 'is given the white unicode pawn representation' do
        expect(@pawn).to have_attributes(representation: "\u265F")
      end

      it 'is given the white pawn vertical movement offset' do
        offsets = [[0, 1], [1, 1], [-1, 1]]
        expect(@pawn).to have_attributes(movement_offsets: offsets)
      end
    end

    context 'when pawn is black' do
      before(:each) do
        @pawn = Pawn.new(:black)
      end

      it 'is given the black unicode pawn representation' do
        expect(@pawn).to have_attributes(representation: "\u2659")
      end

      it 'is given the black pawn vertical movement offset' do
        offsets = [[0, -1], [1, -1], [-1, -1]]
        expect(@pawn).to have_attributes(movement_offsets: offsets)
      end
    end
  end

  describe '#gen_moves' do
    context 'when white pawn has not moved' do
      before(:each) do
        @game = ChessGame.new
        @game.set_up_board
        @white_pawn = @game.board.state[1][1]
      end

      it 'can move forward up to two spaces if not blocked' do
        expect(@white_pawn.gen_moves(@game.board)).to eq [[1, 2], [1, 3]]
      end

      it 'can only move forward one space if blocked by another piece' do
        @game.board.move_piece(1, 6, 1, 3)
        expect(@white_pawn.gen_moves(@game.board)).to eq [[1, 2]]
      end
    end

    context 'when white pawn has moved' do
      game = ChessGame.new
      game.set_up_board
      white_pawn = game.board.state[1][1]
      game.board.move_piece(1, 1, 1, 2)
      it 'can move forward one space while not blocked' do
        expect(white_pawn.gen_moves(game.board)).to eq [[1, 3]]
      end
    end

    context 'whether or not a white pawn has moved' do
      before(:each) do
        @game = ChessGame.new
        @game.set_up_board
        @white_pawn = @game.board.state[1][1]
      end

      it 'cannot move forward if blocked by another piece' do
        @game.board.move_piece(1, 6, 1, 2)
        expect(@white_pawn.gen_moves(@game.board)).to eq []
      end

      it 'cannot move out of bounds' do
        @game.board.state[1][7] = nil
        @game.board.state[1][6] = nil
        @game.board.move_piece(1, 1, 1, 7)
        expect(@white_pawn.gen_moves(@game.board)).to eq []
      end

      it 'can capture pieces of the opposing color' do
        @game.board.move_piece(2, 6, 2, 2)
        moves = [[1, 2], [1, 3], [2, 2]]
        expect(@white_pawn.gen_moves(@game.board)).to eq moves
      end

      it 'cannot capture pieces of the same color' do
        @game.board.move_piece(2, 1, 2, 2)
        expect(@white_pawn.gen_moves(@game.board)).to eq [[1, 2], [1, 3]]
      end
    end

    context 'when black pawn has not moved' do
      before(:each) do
        @game = ChessGame.new
        @game.set_up_board
        @black_pawn = @game.board.state[1][6]
      end

      it 'can move forward up to two spaces if not blocked' do
        expect(@black_pawn.gen_moves(@game.board)).to eq [[1, 5], [1, 4]]
      end

      it 'can only move forward one space if blocked by another piece' do
        @game.board.move_piece(1, 1, 1, 4)
        expect(@black_pawn.gen_moves(@game.board)).to eq [[1, 5]]
      end
    end

    context 'when black pawn has moved' do
      game = ChessGame.new
      game.set_up_board
      black_pawn = game.board.state[1][6]
      game.board.move_piece(1, 6, 1, 5)
      it 'can move forward one space while not blocked' do
        expect(black_pawn.gen_moves(game.board)).to eq [[1, 4]]
      end
    end

    context 'whether or not a black pawn has moved' do
      before(:each) do
        @game = ChessGame.new
        @game.set_up_board
        @black_pawn = @game.board.state[1][6]
      end

      it 'cannot move forward if blocked by another piece' do
        @game.board.move_piece(1, 1, 1, 5)
        expect(@black_pawn.gen_moves(@game.board)).to eq []
      end

      it 'cannot move out of bounds' do
        @game.board.state[1][1] = nil
        @game.board.move_piece(1, 6, 1, 0)
        expect(@black_pawn.gen_moves(@game.board)).to eq []
      end

      it 'can capture pieces of the opposing color' do
        @game.board.move_piece(1, 6, 1, 2)
        expect(@black_pawn.gen_moves(@game.board)).to eq [[2, 1], [0, 1]]
      end

      it 'cannot capture pieces of the same color' do
        @game.board.move_piece(0, 6, 0, 5)
        expect(@black_pawn.gen_moves(@game.board)).to eq [[1, 5], [1, 4]]
      end
    end
  end
end
