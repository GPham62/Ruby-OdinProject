class Board
  def initialize
    @board = {}
  end

  def render
    @board.each do |key, value|
      print "ROUND #{key}: 1-#{value["guess"][0][0].upcase}  2-#{value["guess"][1][0].upcase}  3-#{value["guess"][2][0].upcase}  4-#{value["guess"][3][0].upcase}"
      puts "\tcorrect spot: #{value["correct_spot"]}      correct color: #{value["correct_color"]}"
    end
  end

  def addToBoard(howClose, guess, round)
    @board[round] = {
      "correct_spot" => howClose["correct_spot"],
      "correct_color" => howClose["correct_color"],
      "guess" => guess
    }
  end
end