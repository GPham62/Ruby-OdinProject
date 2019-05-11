require File.expand_path('../../lib/chess_pieces/rook.rb', __dir__)
require File.expand_path('../../lib/chess_game.rb', __dir__)

describe Rook do
  context 'when initialized' do
    it 'initializes a new white rook object with appropriate representation' do
      expect(Rook.new(:white)).to have_attributes(representation: "\u265C")
    end

    it 'initializes a new black rook object with approrpiate representation' do
      expect(Rook.new(:black)).to have_attributes(representation: "\u2656")
    end

    it 'is given the correct movement offsets upon creation' do
      offsets = [[0, 1], [1, 0], [0, -1], [-1, 0]]
      expect(Rook.new(:black)).to have_attributes(movement_offsets: offsets)
    end
  end

  describe '#gen_legal_moves' do
    before(:each) do
      @game = ChessGame.new
      @game.set_up_board
    end

    context 'When the rook is surrounded by pieces of the same color' do
      it 'prevents the rook from making any movements' do
        file, rank = [0, 7]
        rook = @game.board.state[file][rank]
        expect(rook.gen_moves(@game.board)).to eq []
      end
    end

    context 'When rook is free blocked on left' do
      it 'allows the rook to move multiple spaces up, right, or down' do
        @game.board.move_piece(1, 0, 0, 2)
        @game.board.move_piece(1, 1, 1, 3)
        @game.board.move_piece(3, 1, 3, 3)
        @game.board.move_piece(0, 6, 0, 4)
        white_rook = @game.board.state[0][7]
        @game.board.move_piece(0, 7, 1, 4)
        movelist = [[1, 5],
                    [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4],
                    [1, 3]]
        expect(white_rook.gen_moves(@game.board)).to eq movelist
      end
    end
  end
end
