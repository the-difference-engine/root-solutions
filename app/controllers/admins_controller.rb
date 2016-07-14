class AdminsController < ApplicationController
  def new

  end

  def create
    new_user = User.new(email: params[:email], password: params[:password])
    new_user.save
    redirect_to "/"
  end
end
