class AccountsController < ApplicationController
  before_action :authenticate_user!
  
def new
end

def create
  if current_user
  resource = User.new(email: params[:email],password: "password", admin: true)
  if resource.save
    UserMailer.welcome_email_via_admin().deliver_now  
    redirect_to "/resources"
    flash[:success] = "User has been created"
  else
    puts "Not possible"
  end
end
end

def edit
  @user = User.find_by(id: params[:id])
end

def update
  @user = User.find_by(id: params[:id])
  @user.update_attributes(password: params[:password])
  redirect_to "/login"
  flash[:success] = "Your password has been updated. Please login with new password"
end

end
