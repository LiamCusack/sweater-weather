class User < ApplicationRecord
  has_secure_password
  validates :email, :presence => true,
                    :uniqueness => true
  validates :password, :presence => true,
                       :confirmation => true

  has_secure_token :api_key

  def self.authenticate_password(password)
    self.authenticate(password)
  end
end
