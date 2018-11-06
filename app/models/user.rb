class User < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name, :password
  has_secure_password
end
