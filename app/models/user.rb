class User < ActiveRecord::Base
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]

  before_create { self.encrypted_password = Devise.friendly_token[0, 20] }

  before_save { self.email = email.downcase }

  validates :email, presence: true,
                    format:     { with: EMAIL_FORMAT },
                    uniqueness: { case_sensitive: false }

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])
    user
  end
end
