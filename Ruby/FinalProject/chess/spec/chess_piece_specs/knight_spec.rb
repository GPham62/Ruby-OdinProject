require File.expand_path('../../lib/chess_pieces/knight.rb', __dir__)
require File.expand_path('../../lib/chess_game.rb', __dir__)

describe Knight do
  context 'when initialized' do
    it 'initializes a white knight' do
      expect(Knight.new(:white)).to have_attributes(representation: "\u265E")
    end

    it 'initializes a black knight' do
      expect(Knight.new(:black)).to have_attributes(representation: "\u2658")
    end

    it 'has correct movement offsets' do
      offsets = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
      expect(Knight.new(:black)).to have_attributes(movement_offsets: offsets)
    end
  end

  describe '#gen_legal_moves' do
    before(:each) do
      @game = ChessGame.new
      @game.set_up_board
      @white_knight = @game.board.state[1][0]
    end

    it 'allows the knight to move once in its available directions' do
      expect(@white_knight.gen_moves(@game.board)).to eq [[2, 2], [0, 2]]
    end

    it 'allows the knight to capture in any of its available directions' do
      @game.board.move_piece(6, 6, 6, 4)
      @game.board.move_piece(1, 6, 1, 5)
      @game.board.move_piece(1, 0, 1, 4)
      moves = [[2, 6], [3, 5], [3, 3], [2, 2], [0, 2], [0, 6]]
      expect(@white_knight.gen_moves(@game.board)).to eq moves
    end
  end
end
