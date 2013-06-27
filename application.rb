require 'sinatra/base'
require 'instagram'
require 'mongoid'
require './lib/users'

Mongoid.load!("./mongoid.yml")

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  config.client_secret = ENV['INSTAGRAM_SECRET']
end


class CatsAndDogs < Sinatra::Base

  helpers do
    ENV["MONGO_ENV"] = "development"
    def get_photo(tag)
      photos = Instagram.tag_recent_media(tag)
      photos.map do |photo|
        photo.images.standard_resolution.url
      end
    end
  end

  post '/signup' do
    User.create({
      :firstname => params[:firstname],
      :surname => params[:surname],
      :email => params[:email],
      })
    # erb :signup
    redirect to("/signup")
  end

  get '/signup' do
    @users = User.distinct(:firstname)
    erb :signup
  end

  get '/' do
    erb :home
  end

  get '/dogs' do
    @photos = get_photo('petdogs')
    @title = "Dogs"
    erb :display
  end

  get '/cats' do
    @photos = get_photo('petcats')
    @title = "Cats"
    erb :display
  end

end