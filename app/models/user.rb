class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]

  before_validation :generate_devise_password, on: :create
  before_save { self.email = email.downcase }

  validates :email, presence: true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  def self.from_omniauth(access_token)
    data = access_token[:info]
    user = User.find_by(email: data[:email])
    user
  end

  private

  def generate_devise_password
    self.password = Devise.friendly_token[0..20]
  end
end
