require 'sinatra/base'
require 'sinatra/flash'
require 'instagram'

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  config.client_secret = ENV['INSTAGRAM_SECRET']
end


class CatsAndDogs < Sinatra::Base

  get '/' do
    "Hello world"
    dog_photos = Instagram.tag_recent_media('petdog')
    # raise dog_photos.length
    @dog_images = dog_photos.map do |photo|
      photo.images.standard_resolution.url
    end
    erb :home
  end

end