class AdminsController < ApplicationController
  before_action :authenticate_user!
  def new

  end

  def create
    new_user = User.new(email: params[:email], password: params[:password])
    if new_user.save
      UserMailer.welcome_email(new_user).deliver_later
    end
    redirect_to "/"
  end
  def dashboard
    if !current_user
      redirect_to "/login"
    end
    
  end
end
