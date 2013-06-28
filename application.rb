require 'sinatra/base'
require 'instagram'
require 'mongoid'
require 'weather-api'
require 'rest-client'
require_relative './lib/users'

Mongoid.load!("./mongoid.yml")

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  # config.client_secret = ENV['INSTAGRAM_SECRET']
end


API_KEY = ENV['MAILGUN_API_KEY']
API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/mailgun.net"


class CatsAndDogs < Sinatra::Base

  configure do
    use(Rack::Session::Cookie,
      :key => 'rack.session',
      :path => '/',
      :expire_after => 2592000, # In seconds
      :secret => 'I am the secret code to encrypt the cookie')
  end

  helpers do
    ENV["MONGO_ENV"] = "development"

    def get_photo(tag)
      photos = Instagram.tag_recent_media(tag)
      photos.map do |photo|
        photo.images.standard_resolution.url
      end
    end

    def signed_in?
      @user != nil
    end
  end

  before do
    @user = session[:current_user]
  end

  get '/' do
    @weather = Weather.lookup(44418)
    erb :home
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    User.create({ :first_name => params[:first_name],
                  :last_name => params[:last_name],
                  :email => params[:email],
                  :password => params[:password] })
    session[:current_user] = params[:first_name]


  RestClient.post API_URL+"/messages",
      :from => "info@itsrainingcatsanddogs.mailgun.org",
      :to => "params[:email]",
      :subject => "This is subject",
      :text => "Text body",
      :html => "<b>HTML</b> version of the body!"
    redirect '/'
  end

  get '/members' do
    @users = User.all
    erb :members
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

  post '/login' do
    user = User.where(email: params[:email]).first
    if user && user.password == params[:password]
        session[:current_user] = user.first_name
        redirect '/'
    else
      erb :login
    end
  end

  post '/logout' do
    session[:current_user]=nil
    redirect to ('/')
  end

end