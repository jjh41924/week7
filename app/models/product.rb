class Product < ApplicationRecord

  validates :title, presence: true
  validates :description, length: { minimum: 10 }

  validates :price, presence: true, numericality: { greater_than: 0 }

  has_many :reviews, dependent: :destroy


end
