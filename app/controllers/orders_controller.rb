class OrdersController < ApplicationController

  before_action :require_login

  def require_login
    @user = User.find_by(id: session[:user_id])
    if @user.blank?
      redirect_to root_url, notice: "You need to login first."
    end
  end

  def index
    @orders = @user.orders.order('created_at desc')
  end

  def new
    @order = Order.new
    @order.product = Product.find_by(id: params[:product_id])
    render 'new'
  end

  def create
    @order = Order.new            # why is this an instance variable?
    @order.product = Product.find_by(id: params[:product_id])
    @order.user = @user

    if @order.save
      redirect_to root_url, notice: "Thanks for your order! We will ship it when we feel like it."
    else
      @product = @order.product
      render 'new'
    end
  end

end
