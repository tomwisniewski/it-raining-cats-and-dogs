require 'sinatra/base'
require 'instagram'
require 'mongoid'
require 'weather-api'
require 'pony'
require_relative './lib/user'
require_relative './lib/cats_and_dogs_helpers'

Mongoid.load!("./mongoid.yml")

class CatsAndDogs < Sinatra::Base

  Instagram.configure do |config|
    config.client_id = ENV['INSTAGRAM_ID']
  end
  
  configure do
    use(Rack::Session::Cookie,
      :key => 'rack.session',
      :path => '/',
      :expire_after => 2592000, # In seconds
      :secret => 'I am the secret code to encrypt the cookie')
  end

  helpers CatsAndDogsHelpers

  helpers do
   
    def signed_in?
      @user != nil
    end

    # def send_raining_email
    #   if @weather.condition.text.include?("Cloudy") || @weather.condition.text.inlude?("Rain")
    #     User.all.each { |user| Pony.mail(:to => user.email, :from => 'info@itsraining.com', :subject => 'itsrainingcatsanddogs!!!', :body => "It's raining - log in, quick!") }
    #   end  
    # end  
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
    create_user(params[:first_name], params[:last_name], params[:email], params[:password])
    session[:current_user] = params[:first_name]
    pony_options
    send_welcome_email(params[:email])
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
    verify_login(params[:email], params[:password])
  end

  post '/logout' do
    session[:current_user] = nil
    redirect to ('/')
  end

  post '/search' do
    hashtag = params['hashtag']
    @photos = get_photo(hashtag)
    @title = "##{hashtag}"
    erb :display
  end

end