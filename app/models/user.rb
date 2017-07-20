class User < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true

  has_many :orders

  # def orders
  #   Order.where(user_id: self.id)
  # end

  has_secure_password

  # 1. Expects a column named password_digest
  # 2. Provides an attr_accessor :password
  # 3. Provides a method named .authenticate(pwd)

end
