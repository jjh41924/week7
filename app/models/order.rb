class Order < ApplicationRecord

  belongs_to :product
  belongs_to :user

  def total_amount
    (product.price / 100.0).round(2)
  end
  
  def valid_credit_card_number
    # TODO: implement Luhn algorithm here
    #
    # To cause this validation to stop the persistence chain,
    # simply add an error to the .errors collection that is
    # attached to this object.

  end


end
