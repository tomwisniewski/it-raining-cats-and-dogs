require 'mongoid'

class User
  include Mongoid::Document
  field :firstname, :type => String
  field :surname, :type => String
  field :email, :type => String
  field :password, :type => String

  def full_name
    "#{firstname} #{surname}"
  end

end
