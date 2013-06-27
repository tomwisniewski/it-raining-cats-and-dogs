require 'mongoid'

class User
  include Mongoid::Document

  field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  field :password, :type => String

  def full_name
    "#{first_name} #{last_name}"
  end

  # try to validate
  # validates :first_name, :presence => true
  # validates :last_name, :presence => true
  # validates :email, :presence => true, :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i }
  # validates :password, :presence => true, length: { minimum: 6 }

end
