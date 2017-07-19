class ReviewsController < ApplicationController

  def create
    review = Review.new
    review.product_id = params['product_id']
    review.rating = params['rating']
    review.content = params['content']
    review.save
    redirect_to "/products/#{review.product_id}", notice: "Thanks for your review!"
  end

end
