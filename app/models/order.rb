class Order < ApplicationRecord

  belongs_to :product
  belongs_to :user

  # General form
  # belongs_to :product, class_name: "Product",
  #                      foreign_key: :product_id

  # def product
  #   Product.find_by(id: self.product_id)
  # end
  #
  # def user
  #   User.find_by(id: self.user_id)
  # end



end
