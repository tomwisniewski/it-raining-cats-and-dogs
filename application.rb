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
    dog_photos = Instagram.tag_recent_media('dog')
    dog_photos.each do |photo|
      puts photo.images.standard_resolution.url
    end
  end

# puts Instagram.tag('cat')
# @a = Instagram.tag_recent_media('dog')
# json = File.read(@a)
# puts JSON.parse(json)
end