class AdminsController < ApplicationController
  def new

  end

  def create
    new_user = User.new(email: params[:email])
    new_user.save
    redirect_to "/"
  end
end
