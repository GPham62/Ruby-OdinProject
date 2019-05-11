require '../lib/chess_board.rb'

describe ChessBoard do
    before(:each) do
        @board = ChessBoard.new
    end

    describe '#to_s' do
        correct_board = <<~CORRECT_BOARD 
        ┌───┬───┬───┬───┬───┬───┬───┬───┐
      8 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      7 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      6 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      5 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      4 │   │   │   │ ♔ │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      3 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      2 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      1 │   │   │   │   │   │   │   │   │
        └───┴───┴───┴───┴───┴───┴───┴───┘
          a   b   c   d   e   f   g   h  \n\n
        CORRECT_BOARD

        it 'displays the state of the chessboard to the players' do
            king = double('chess_piece')
            allow(king).to receive(:representation) { "\u2654" }
            @board.state[3][3] = king
            expect{ @board.to_s }.to output(correct_board.chomp).to_stdout
        end
    end

    describe '#convert_coords_to_arr_idxs' do
      it 'converts file and rank coordinates to array indexes' do
        expect(@board.convert_coords_to_arr_idxs(['g', 6])).to eq([6, 5])
      end
    end

    describe '#move_piece' do
      before(:each) do 
        @pawn = double('pawn')
        allow(@pawn).to receive(:coords=) {[0, 7]}
        @board.state[0][6] = @pawn
        @board.move_piece(0, 6, 0, 7)
      end

      it 'updates the state of the board at the new given coordinates' do
        expect(@board.state[0][7]).to eq(@pawn)
      end

      it 'updates the state of the board at the old given coordinates' do
        expect(@board.state[0][6]).to eq(nil)
      end
    end
end