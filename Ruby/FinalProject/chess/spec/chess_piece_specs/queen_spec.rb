require File.expand_path("../../../lib/chess_pieces/queen.rb", __FILE__)
require File.expand_path("../../../lib/chess_game.rb", __FILE__)

describe Queen do
  context 'when initialized' do
    it 'initializes a new white queen object with appropriate representation' do
      expect(Queen.new(:white)).to have_attributes(representation: "\u265B")
    end
    
    it 'initializes a new white queen object with appropriate representation' do
      expect(Queen.new(:black)).to have_attributes(representation: "\u2655")
    end
    
    it 'is given the correct movement offsets upon creation' do
      offsets = [[0, 1], [1, 1], [1, 0], [1, -1], 
                 [0, -1], [-1, -1], [-1, 0], [-1, 1]]
      expect(Queen.new(:black)).to have_attributes(movement_offsets: offsets)
    end
  end
  
  describe '#gen_legal_moves' do
    before(:each) do
      @game = ChessGame.new
      @game.set_up_board
    end

    context 'When queen is surrounded by pieces of the same color' do
      it 'prevents the queen from making any movements' do
        file, rank = [3, 7]
        queen = @game.board.state[file][rank]
        expect(queen.gen_moves(@game.board)).to eq []
      end
    end

    context 'When queen is free to move in any direction' do            
      it 'allows the queen to move multiple spaces in any direction' do
        @game.board.move_piece(0, 1, 0, 3)
        @game.board.move_piece(7, 1, 7, 3)
        @game.board.move_piece(3, 6, 3, 2)
        black_queen = @game.board.state[3][7]
        @game.board.move_piece(3, 7, 3, 4)
        movelist = [[3, 5], [3, 6], [3, 7], 
                    [4, 5], 
                    [4, 4], [5, 4], [6, 4], [7, 4],
                    [4, 3], [5, 2], [6, 1], 
                    [3, 3], 
                    [2, 3], [1, 2], [0, 1], 
                    [2, 4], [1, 4], [0, 4], 
                    [2, 5]]
        expect(black_queen.gen_moves(@game.board)).to eq movelist
      end
    end
  end
end
