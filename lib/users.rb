require 'mongoid'

class User
  include Mongoid::Document
  field :name, :type => string,
  field :email, :type => string,
  field :password, :type => string
end
