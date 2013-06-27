require_relative '../application'
require 'minitest'
require 'minitest/autorun'
require 'rack/test'

class CatsAndDogsTest < Minitest::Test

  def setup
    @browser = Rack::Test::Session.new(Rack::MockSession.new(CatsAndDogs))
  end

  def test_it_shows_the_homepage
    @browser.get '/'
    assert @browser.last_response.ok?
    assert @browser.last_response.body.include? "It's raining"
  end

end