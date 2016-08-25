class AdminsController < ApplicationController
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
    
  end
end
