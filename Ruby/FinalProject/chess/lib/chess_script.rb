require_relative 'chess_game'
require 'yaml'

def title_screen
    title = File.readlines('../design_docs/script/title_screen.txt')
    title.each do |line|
        puts line
    end
end

def load_game
    if File.exists?('../saves/chess.yaml')
        save_file = File.open('../saves/chess.yaml', 'r')
        game = YAML.load(save_file)
    else
        puts "No saved games.\n"
        select_title_screen_option
    end
end

def select_title_screen_option
    print '(S)tart' + "\t"*4 + '(L)oad' + "\t"*4 + '(Q)uit'
    print "\n\nSelect one of the above options to get started: "
    selection = gets.chomp.downcase
    case selection
    when 's' then start_game
    when 'l' then start_game(load_game)
    when 'q' then exit
    else select_title_screen_option
    end
end

def welcome_message
    welcome = File.readlines('../design_docs/script/welcome_message.txt')
    print "\n"*2
    welcome.each do |line|
        puts line
    end
    print "\n"*2
end

def save_and_quit(game)
    yaml = YAML::dump(game)
    File.open('../saves/chess.yaml', 'w') { |file| file.puts yaml}
    exit
end

def play_turn(game)
    if game.check_mate?
        puts "Checkmate, #{game.player}, you lose!"
        chess_program
    end
    print '(M)ove a piece, (s)ave and quit, or (q)uit?:  '
    selection = gets.chomp.downcase
    if selection == 'm'
        game.move_a_piece
        game.turn += 1 if game.player == :black
        game.switch_players
        return game
    end
    save_and_quit(game) if selection == 's'
    exit if selection == 'q' 
    play_turn(game)
end

def run(game)
    game.board.to_s
    puts "Turn #{game.turn}, #{game.player.capitalize}'s turn. "
    run(play_turn(game))
end

def start_game(game = nil)
    welcome_message
    unless game
        game = ChessGame.new
        game.set_up_board
    end
    run(game)
end

def chess_program
    title_screen
    select_title_screen_option
end

chess_program