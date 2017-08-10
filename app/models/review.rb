class Review < ApplicationRecord

  belongs_to :product

  after_destroy :log_it_out

  def log_it_out
    Rails.logger.info "Review #{self.id} was deleted!"
  end

end
