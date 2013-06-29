require_relative '../application'
require 'mongoid'
require 'database_cleaner'
require 'rspec'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'

Capybara.app = CatsAndDogs

def signup_user
    user = User.new
    user.first_name = "Dario"
    user.last_name = "D'Aprile"
    user.email = "dario@gmail.com"
    user.password = "tomtom"
    visit "/signup"
    fill_in "first_name", :with => user.first_name
    fill_in "last_name", :with => user.last_name
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Sign Up"
end

 
