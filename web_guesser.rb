require 'sinatra'
require 'sinatra/reloader'

def new_game
  @@guesses_left = 6
  @@random = make_random
  @@guess = ""
  @@color = 'background-color: black'
end

def make_random
  rand(1..100)
end

def get_input
  if @@guess == ""
    @@message = "Guess a number from 1 -100"
  else
    @@guess = params["guess"].to_i
    check_guess
  end
end

def check_guess
  if @@guess == @@random
    @@message = "Thats it! The number was #{@@random}"
    winner
  elsif @@guesses_left == 1
    game_over
  else
    @@guesses_left -= 1
    message_maker
  end
end

def message_maker
  @@message = "High, But Closer" if @@guess - @@random > 1
  @@message = "Too Damn High!" if @@guess - @@random > 15
  @@message = "Low, But Closer" if @@guess - @@random < 0
  @@message = "Too Damn Low!" if @@guess - @@random < -15
end

def winner 
  @@message = "WOW you guessed it! #{@@random}"
  new_game
end

def game_over
  @@message = "All Over! The Number Was: #{@@random}!"
  new_game
end

new_game

get '/' do 
  @@guess = params["guess"]
  get_input
  erb :index, :locals => {
    :message => @@message, 
    :guesses_left => @@guesses_left
  }
end
