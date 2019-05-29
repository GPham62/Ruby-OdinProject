require 'sinatra'
require 'sinatra/reloader'
require './lib/code.rb'

game = Hangman.new

get '/' do
  erb :index, locals: {
    progress: game.progress,
    incorrect_letters: game.incorrect_letters.join(', '),
    chance: game.chance,
    message: game.message,
  }
end

post '/' do
  unless params[:guess_letter].empty?
    guess = params[:guess_letter]
    game.guess_letter(guess)
  end
  erb :index, locals: {
    progress: game.progress,
    incorrect_letters: game.incorrect_letters.join(', '),
    chance: game.chance,
    message: game.message
  }
end