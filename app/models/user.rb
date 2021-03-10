class User < ApplicationRecord
  validates :password, :confirmation => true
end
