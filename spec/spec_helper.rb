require_relative '../application'
require 'mongoid'
require 'database_cleaner'
require 'rspec'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'

Capybara.app = CatsAndDogs