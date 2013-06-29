require 'sinatra/base'
require_relative 'user'

module CatsAndDogsHelpers

  def pony_options
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
  end  

  def get_photo(tag)
    photos = Instagram.tag_recent_media(tag)
    photos.map do |photo|
      photo.images.standard_resolution.url
    end
  end

  def create_user(first_name, last_name, email, password)
    User.create({ :first_name => first_name,
                  :last_name => last_name,
                  :email => email,
                  :password => password
                })
  end  

  def send_welcome_email(email)
    Pony.mail(:to => email, 
              :from => 'info@itsraining.com', 
              :subject => 'Welcome to itsrainingcatsanddogs.herokuapp.com', 
              :body => "Hello #{params[:first_name]}\n\n
              Thank-you for registering at itsrainingcatsanddogs.herokuapp.com.\n\n
              Your premium features include:\n
              -custom Instagram search\n
              -regular email updates with cats and dogs when it's raining\n\n
              We hope you enjoy your time with us\n\n
              Much love,
              \nitsrainingcatsanddogs team x"
              )
  end

  def verify_login(email, password)
    user = User.where(email: email).first
    if user && user.password == password
        session[:current_user] = user.first_name
        redirect '/'
    else
      erb :login
    end
  end  

end  