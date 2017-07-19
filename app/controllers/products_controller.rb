class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params["id"])
    @reviews = Review.where(product_id: @product.id)
  end

  def new
  end

  def create
    p = Product.new
    p.title = params["title"]
    p.price = params["price"].to_f * 100
    p.description = params["description"]
    p.photo_url = params["photo_url"]
    p.save

    redirect_to "/products", notice: 'Product successfully created.'
  end

  def edit
    @product = Product.find_by(id: params["id"])
  end

  def update
    p = Product.find_by(id: params["id"])
    p.title = params["title"]
    p.price = params["price"].to_f * 100
    p.description = params["description"]
    p.photo_url = params["photo_url"]
    p.save

    redirect_to "/products/#{p.id}", notice: 'Product successfully updated.'
  end

  def destroy
    product = Product.find_by(id: params["id"])
    product.delete
    redirect_to "/products",  notice: 'Product toasted!'
  end
end
