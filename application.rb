require 'sinatra/base'
require 'sinatra/flash'
require 'instagram'
require 'mongoid'

Mongoid.load!("./mongoid.yml")

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  config.client_secret = ENV['INSTAGRAM_SECRET']
end


class CatsAndDogs < Sinatra::Base

  helpers do
    # ENV["MONGO_ENV"] = "development"
    def get_photo(tag)
      photos = Instagram.tag_recent_media(tag)
      photos.map do |photo|
        photo.images.standard_resolution.url
      end
    end
  end

  post '/signup' do

  end

  get '/' do
    erb :home
  end

  get '/dogs' do
    @photos = get_photo('petdogs')
    erb :display
  end

  get '/cats' do
    @photos = get_photo('petcats')
    erb :display
  end

end