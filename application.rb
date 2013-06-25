require 'sinatra/base'
require 'sinatra/flash'
require 'instagram'
require 'json'

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  config.client_secret = ENV['INSTAGRAM_SECRET']
end


class CatsAndDogs < Sinatra::Base

  get '/' do
    "Hello world"
    dog_photos = Instagram.tag_recent_media('catanddogs')
    # raise dog_photos.length
    @dog_images = dog_photos.map do |photo|
      photo.images.standard_resolution.url
    end
    erb :home
  end

# puts Instagram.tag('cat')
# @a = Instagram.tag_recent_media('dog')
# json = File.read(@a)
# puts JSON.parse(json)
end