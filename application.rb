require 'sinatra/base'
require 'instagram'
require 'mongoid'
require 'weather-api'
require 'pony'

require_relative './lib/users'

Mongoid.load!("./mongoid.yml")

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  # config.client_secret = ENV['INSTAGRAM_SECRET']
end



class CatsAndDogs < Sinatra::Base

  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }


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

    Pony.mail(:to => params[:email], :subject => 'hi', :body => 'Hello there.')

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

  post '/search' do
    @photos = get_photo('#{search}')
    @title = "#{search}"
    erb :display
  end

end