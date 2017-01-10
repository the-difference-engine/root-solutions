class AdminsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    new_user = User.new(email: params[:email], password: params[:password])
    if new_user.save
      UserMailer.welcome_email(new_user).deliver_later
    end
    redirect_to "/"
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.update_attributes(email: params[:user_email], password: params[:user_password])
    redirect_to "/admins/#{@user.id}"
  end
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to "/admins"
  end
  def dashboard
    if !current_user
      redirect_to "/login"
    end
    
  end
end
