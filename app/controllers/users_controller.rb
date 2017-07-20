class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new
    user.name = params['name']
    user.email = params['email']
    user.password = params['password']
    user.save
    redirect_to users_url, notice: "Thanks for signing up!"
  end

  def index
  end

  def show
    @user = User.find_by(id: params["id"])

    if @user.present? && @user.id == session["user_id"]
      @orders = Order.where(user_id: @user.id)
    else
      redirect_to root_url, notice: "Nice try!"
    end
  end


end
