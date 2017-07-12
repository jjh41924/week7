class SessionsController < ApplicationController

  def new
  end

  def create
    redirect_to new_session_url, alert: ["Unknown email or password.", "I don't think so.", "Nice try."].sample
  end

  def destroy
    redirect_to root_url, notice: "See ya!"
  end

end
