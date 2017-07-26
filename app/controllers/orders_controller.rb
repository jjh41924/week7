class OrdersController < ApplicationController

  def index
    user = User.find_by(id: session[:user_id])
    if user.blank?
      redirect_to root_url, notice: "You need to login first."
    else
      @orders = Order.all.order('created_at desc')
    end
  end
  
  def new
    user = User.find_by(id: session[:user_id])
    if user.blank?
      redirect_to root_url, notice: "You need to login first."
    else
      @order = Order.new
      @order.product = Product.find_by(id: params[:product_id])
      render 'new'
    end
  end

  def create
    user = User.find_by(id: session[:user_id])
    if user.blank?
      redirect_to root_url, notice: "You need to login first."
    else
      @order = Order.new            # why is this an instance variable?
      @order.product = Product.find_by(id: params[:product_id])
      @order.user = user
      if @order.save
        redirect_to root_url, notice: "Thanks for your order! We will ship it when we feel like it."
      else
        @product = @order.product
        render 'new'
      end
    end
  end

end
