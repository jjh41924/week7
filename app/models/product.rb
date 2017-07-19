class Product < ApplicationRecord

  validates :title, presence: true
  validates :description, length: { minimum: 10 }

  validates :price, presence: true, numericality: { only_integer: true }

end
