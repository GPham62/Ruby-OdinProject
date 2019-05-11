require File.expand_path("../../lib/chess_game.rb", __FILE__)

describe ChessGame do
  before(:each) { @game = ChessGame.new }

  describe '#initialize' do
    it {is_expected.to have_attributes(:board => ChessBoard)}
    it {is_expected.to have_attributes(:player => :white)}
    it {is_expected.to have_attributes(:turn => 1)}
  end

  describe '#set_up_board' do
    expected_board = <<~BOARD
        ┌───┬───┬───┬───┬───┬───┬───┬───┐
      8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      7 │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      6 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      5 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      4 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      3 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      2 │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │
        └───┴───┴───┴───┴───┴───┴───┴───┘
          a   b   c   d   e   f   g   h  \n\n
    BOARD

    it 'creates and adds all the chess pieces to the board' do
        @game.set_up_board
        expect { @game.board.to_s }.to output(expected_board.chomp).to_stdout
    end
    
    it 'returns nothing' do
        expect(@game.set_up_board).to be nil
    end        
  end

  describe '#choose_a_piece_to_move' do
    before(:each) do
      @game.set_up_board
    end

    context 'when user input is invalid' do
      it 'raises and rescues a runtime error and prints its message' do
        allow(@game).to receive(:gets).and_return("a23", "a2")
        output = "Invalid input, try again. " 
        expect { @game.choose_a_piece_to_move }.to output(output).to_stdout
      end
    end
    
    context 'when user chooses an empty space' do
      it 'raises and rescues a runtime error and prints its message' do
        allow(@game).to receive(:gets).and_return("a4", "d2")
        output = "No chess piece at the selected coordinates. "
        expect { @game.choose_a_piece_to_move }.to output(output).to_stdout
      end
    end

    context 'when user chooses a chess piece that is not their color' do
      it 'raises and rescues a runtime error and prints its message' do
        allow(@game).to receive(:gets).and_return('d7', 'a2')
        output = 'Not your piece to move. '
        expect { @game.choose_a_piece_to_move }.to output(output).to_stdout
      end
    end

    context 'when user chooses a chess piece that cannot move' do
      it 'raises and rescues a runtime error and prints its message' do
        allow(@game).to receive(:gets).and_return("d1", "g2")
        output = "That piece cannot move. "
        expect { @game.choose_a_piece_to_move }.to output(output).to_stdout
      end
    end

    context 'user chooses a piece with moves that would put it in check' do
      it 'removes the illegal moves and returns the list of remaining moves' do
        @game.board.move_piece(1, 0, 2, 2)
        @game.board.move_piece(4, 1, 4, 3)
        @game.board.move_piece(5, 1, 5, 2)
        @game.board.move_piece(2, 6, 2, 5)
        @game.board.move_piece(3, 7, 1, 4)
        allow(@game).to receive(:gets).and_return("e1")
        expect(@game.choose_a_piece_to_move).to eq [4, 0, [[5, 1]]]
      end

      it 'removes the illegal moves and returns the list of remaining moves' do
        @game.board.move_piece(1, 0, 2, 2)
        @game.board.move_piece(4, 1, 4, 3)
        @game.board.move_piece(4, 6, 4, 5)
        @game.board.move_piece(3, 7, 7, 3)
        allow(@game).to receive(:gets).and_return("f2", 'b2')
        msg = "That piece cannot move. "
        expect { @game.choose_a_piece_to_move }.to output(msg).to_stdout
      end

      it 'removes valid moves after a king is already in check' do
        @game.board.move_piece(2, 1, 2, 2)
        @game.board.move_piece(5, 1, 5, 2)
        @game.board.move_piece(4, 6, 4, 5)
        @game.board.move_piece(3, 7, 7, 3)
        allow(@game).to receive(:gets).and_return("f3", 'g2')
        output = "That piece cannot move. "
        expect { @game.choose_a_piece_to_move }.to output(output).to_stdout
      end

      it 'removes valid moves after a king is already in check' do
        @game.board.move_piece(1, 0, 2, 6)
        @game.board.move_piece(6, 6, 6, 5)
        @game.board.move_piece(0, 6, 0, 5)
        @game.board.move_piece(6, 7, 7, 5)
        @game.switch_players
        allow(@game).to receive(:gets).and_return("f7", 'd8')
        output = "That piece cannot move. "
        expect { @game.choose_a_piece_to_move }.to output(output).to_stdout
      end        
    end

    context 'when user chooses a chess piece with valid movements' do
      it 'returns an array containing the chosen file and rank' do
        allow(@game).to receive(:gets).and_return('a2')
        file, rank, possible_moves = @game.choose_a_piece_to_move
        expect(file).to eq 0
        expect(rank).to eq 1
      end

      it 'returns an array containing possible moves from the chosen coords' do
        allow(@game).to receive(:gets).and_return('a2')
        file, rank, possible_moves = @game.choose_a_piece_to_move
        expect(possible_moves).to eq [[0, 2], [0, 3]]
      end
    end
  end

  describe '#display_moves' do
    before(:each) do
      @game.set_up_board
      allow($stdout).to receive(:write)
    end

    it "puts X's in board spaces that can be moved to from a chosen space" do
      moves = [[3, 2], [3, 3]]
      display = <<~DISPLAYBOARD
        ┌───┬───┬───┬───┬───┬───┬───┬───┐
      8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      7 │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      6 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      5 │   │   │   │   │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      4 │   │   │   │ X │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      3 │   │   │   │ X │   │   │   │   │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      2 │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │
        └───┴───┴───┴───┴───┴───┴───┴───┘
          a   b   c   d   e   f   g   h  \n\n
      DISPLAYBOARD
      expect {@game.display_moves(moves)}.to output(display.chomp).to_stdout
    end

    it 'does not put an X in a space occupied by the king' do
      @game.board.move_piece(5, 1, 5, 2)
      @game.board.move_piece(4, 6, 4, 5)
      @game.board.move_piece(2, 1, 2, 3)
      @game.board.move_piece(3, 7, 7, 3)
      moves = @game.board.state[7][3].gen_moves(@game.board)
      display = <<~DISPLAYBOARD
        ┌───┬───┬───┬───┬───┬───┬───┬───┐
      8 │ ♖ │ ♘ │ ♗ │ X │ ♔ │ ♗ │ ♘ │ ♖ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      7 │ ♙ │ ♙ │ ♙ │ ♙ │ X │ ♙ │ ♙ │ ♙ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      6 │   │   │   │   │ ♙ │ X │   │ X │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      5 │   │   │   │   │   │   │ X │ X │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      4 │   │   │ X │ X │ X │ X │ X │ ♕ │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      3 │   │   │   │   │   │ ♟ │ X │ X │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      2 │ ♟ │ ♟ │   │ ♟ │ ♟ │ X │ ♟ │ X │
        ├───┼───┼───┼───┼───┼───┼───┼───┤
      1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │
        └───┴───┴───┴───┴───┴───┴───┴───┘
          a   b   c   d   e   f   g   h  \n\n
      DISPLAYBOARD

      expect{ @game.display_moves(moves) }.to output(display.chomp).to_stdout
    end

    it 'does not modify the original board' do
      board = <<~BOARD
          ┌───┬───┬───┬───┬───┬───┬───┬───┐
        8 │ ♖ │ ♘ │ ♗ │ ♕ │ ♔ │ ♗ │ ♘ │ ♖ │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        7 │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │ ♙ │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        6 │   │   │   │   │   │   │   │   │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        5 │   │   │   │   │   │   │   │   │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        4 │   │   │   │   │   │   │   │   │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        3 │   │   │   │   │   │   │   │   │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        2 │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │ ♟ │
          ├───┼───┼───┼───┼───┼───┼───┼───┤
        1 │ ♜ │ ♞ │ ♝ │ ♛ │ ♚ │ ♝ │ ♞ │ ♜ │
          └───┴───┴───┴───┴───┴───┴───┴───┘
            a   b   c   d   e   f   g   h  \n\n
      BOARD
      moves = [[3, 2], [3, 3]]
      @game.display_moves(moves)
      expect {@game.board.to_s}.to output(board.chomp).to_stdout
    end
  end

  describe '#choose_move' do
    before(:each) do
      @game.set_up_board
      allow($stdout).to receive(:write)
    end

    context 'when user input is invalid' do
      it 'raises and rescues a runtime error and prints its message.' do
        moves = [[3, 2], [3, 3]]
        e_msg = "Invalid input, try again. "
        allow(@game).to receive(:gets).and_return('d5t', 'd4')
        expect {@game.choose_move(moves)}.to output(e_msg).to_stdout
      end
    end

    context 'when user chooses an invalid move' do
      it 'raises and rescues a runtime error and prints its message.' do
        moves = [[3, 2], [3, 3]]
        e_msg = "The move you chose is invalid, try again. "
        allow(@game).to receive(:gets).and_return('d5', 'd4')
        expect {@game.choose_move(moves)}.to output(e_msg).to_stdout
      end
    end

    context 'when user chooses a valid move' do
      it 'returns the coordinates of the move' do
        moves = [[3, 2], [3, 3]]
        allow(@game).to receive(:gets).and_return('d4')
        expect(@game.choose_move(moves)).to eq [3, 3]
      end
    end
  end

  describe '#check_mate?' do
    before(:each) do
      @game = ChessGame.new
      board_setup = [[Knight.new(:black, [0, 0]), Pawn.new(:white, [0, 1]), nil,
        King.new(:white, [0, 3]), Pawn.new(:black, [0, 4]), nil, nil, nil],
      [nil, Pawn.new(:white, [1, 1]), nil, nil, nil, nil, nil, nil],
      [Bishop.new(:white, [2, 0]), nil, Knight.new(:white, [2, 2]), Bishop.new(:white, [2, 3]), Queen.new(:black, [2, 4]), nil, nil, King.new(:black, [2, 7])],
      [nil, nil, Pawn.new(:white, [3, 2]), nil, nil, nil, nil, Rook.new(:black, [3, 7])],
      [nil, nil, nil, nil, nil, nil, Pawn.new(:black, [4, 6]), nil],
      [Rook.new(:white, [5, 0]), Pawn.new(:white, [5, 1]), nil, nil, Pawn.new(:black, [5, 4]), nil, nil, nil],
      [nil, Pawn.new(:white, [6, 1]), nil, Pawn.new(:black, [6, 3]), nil, nil, nil, nil],
      [nil, Pawn.new(:white, [7, 1]), nil, nil, nil, Bishop.new(:black, [7, 5]), Pawn.new(:black, [7, 6]), Rook.new(:black, [7, 7])]]
      @game.board.state = board_setup
      @game.switch_players
    end

    it "returns false if the opponent's king is not under mate" do
      expect(@game.check_mate?).to be false
    end

    it "returns true if the opponent's king is under mate" do
      allow(@game).to receive(:gets).and_return('c5', 'b4')
      @game.move_a_piece
      @game.switch_players
      expect(@game.check_mate?).to be true
    end 
  end
end