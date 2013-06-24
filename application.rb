require 'sinatra/base'
require 'sinatra/flash'

class CatsAndDogs < Sinatra::Base

  get '/' do
    "Hello world"
  end 

end  