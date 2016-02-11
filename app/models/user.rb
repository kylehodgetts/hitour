class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
end
