require 'sinatra/base'
require 'sinatra/flash'
require 'instagram'

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
end


class CatsAndDogs < Sinatra::Base

  get '/' do
    "Hello world"
  end

end