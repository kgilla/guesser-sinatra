require 'sinatra'
require 'sinatra/reloader'

random = rand(100)

get '/' do 
  erb :index, :locals => {:random => random}
end

