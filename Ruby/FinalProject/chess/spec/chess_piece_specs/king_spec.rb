require File.expand_path('../../lib/chess_pieces/king.rb', __dir__)
require File.expand_path('../../lib/chess_game.rb', __dir__)

describe King do
  context 'when initialized' do
    it 'initializes a king object with white representation' do
      expect(King.new(:white)).to have_attributes(representation: "\u265A")
    end

    it 'initializes a king object with black representation' do
      expect(King.new(:black)).to have_attributes(representation: "\u2654")
    end

    it 'is has the correct movement offsets' do
      offsets = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
      expect(King.new(:black)).to have_attributes(movement_offsets: offsets)
    end
  end

  describe '#gen_moves' do
    before(:each) do
      @game = ChessGame.new
      @game.set_up_board
      @white_king = @game.board.state[4][0]
    end

    it 'does not allow the king to move when blocked by other same-color pieces' do
      expect(@white_king.gen_moves(@game.board)).to eq []
    end

    it 'allows the king to move once in any available direction' do
      @game.board.move_piece(4, 1, 4, 3)
      @game.board.move_piece(4, 0, 4, 1)
      moves = [[4, 2], [5, 2], [4, 0], [3, 2]]
      expect(@white_king.gen_moves(@game.board)).to eq moves
    end

    it 'allows the king to capture pieces of the opposite color' do
      @game.board.move_piece(3, 6, 3, 2)
      @game.board.move_piece(4, 1, 4, 3)
      @game.board.move_piece(4, 0, 4, 1)
      moves = [[4, 2], [5, 2], [4, 0], [3, 2]]
      expect(@white_king.gen_moves(@game.board)).to eq moves
    end
  end
end
