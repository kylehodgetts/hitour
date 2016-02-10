require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  attr_accessor :password
  has_secure_password

  before_create :encrypt_password
  before_save { self.email = email.downcase }

  private

  def encrypt_password
    self.password_digest = BCrypt::Engine
  end

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = Bcrypt::Password.create(new_password)
    self.password_digest = @password
  end
end
