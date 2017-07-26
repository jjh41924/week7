class Order < ApplicationRecord

  belongs_to :product
  belongs_to :user

  before_validation :cleanup_card_number
  validate :valid_credit_card_number

  def cleanup_card_number
    card_number.gsub!(/\D/,'')
  end

  def total_amount
    (product.price / 100.0).round(2)
  end

  def valid_credit_card_number
    # TODO: implement Luhn algorithm here
    #
    # To cause this validation to stop the persistence chain,
    # simply add an error to the .errors collection that is
    # attached to this object.
    if card_number.blank? || card_number.length != 16
      errors.add(:card_number, "is invalid")
    end
  end


end
