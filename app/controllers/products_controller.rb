class ProductsController < ApplicationController

  def index
    @products = Product.page(params["page"]).per(2)
  end

  def show
    @product = Product.find_by(id: params["id"])
    @reviews = Review.where(product_id: @product.id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    @product.title = params["title"]
    @product.price = params["price"].to_f * 100
    @product.description = params["description"]
    @product.photo_url = params["photo_url"]
    if @product.save
      redirect_to "/products", notice: 'Product successfully created.'
    else
      render "new"
    end
  end

  def edit
    @product = Product.find_by(id: params["id"])
  end

  def update
    @product = Product.find_by(id: params["id"])
    @product.title = params["title"]
    @product.price = params["price"].to_f * 100
    @product.description = params["description"]
    @product.photo_url = params["photo_url"]
    if @product.save
      redirect_to "/products/#{@product.id}", notice: 'Product successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    product = Product.find_by(id: params["id"])
    product.delete
    # TO DO: Delete all existing reviews
    redirect_to "/products",  notice: 'Product toasted!'
  end
end
