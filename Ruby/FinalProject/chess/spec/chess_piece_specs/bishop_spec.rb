require File.expand_path("../../../lib/chess_pieces/bishop.rb", __FILE__)
require File.expand_path("../../../lib/chess_game.rb", __FILE__)

describe Bishop do
  context 'when intialized' do
    it 'initializes a new white bishop object with appropriate representation' do
      expect(Bishop.new(:white)).to have_attributes(representation: "\u265D")
    end
    
    it 'initializes a new black bishop object with appropriate representation' do
      expect(Bishop.new(:black)).to have_attributes(representation: "\u2657")
    end
    
    it 'is given the correct movement offsets upon creation' do
      move_offsets = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
      expect(Bishop.new(:black)).to have_attributes(movement_offsets: move_offsets)
    end
  end
  
  describe '#gen_legal_moves' do
    before(:each) do
      @game = ChessGame.new
      @game.set_up_board
    end

    context 'When the bishop is surrounded by pieces of the same color' do
      it 'prevents the bishop from making any movements' do
        file, rank = [2, 0]
        bishop = @game.board.state[file][rank]
        expect(bishop.gen_moves(@game.board)).to eq []
      end
    end

    context 'When bishop is free to move in any direction' do            
      it 'allows the bishop to move multiple spaces in any direction' do
        @game.board.move_piece(1, 1, 1, 3)
        @game.board.move_piece(6, 7, 5, 5)
        @game.board.move_piece(2, 6, 2, 5)
        white_bishop = @game.board.state[2][0]
        @game.board.move_piece(2, 0, 3, 3)
        movelist = [[4, 4], [5, 5],
                    [4, 2], 
                    [2, 2], [1, 1],
                    [2, 4], [1, 5], [0, 6]]
        expect(white_bishop.gen_moves(@game.board)).to eq movelist
      end
    end
  end
end
