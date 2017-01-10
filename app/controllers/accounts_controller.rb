class AccountsController < ApplicationController
  before_action :authenticate_user!
  
def new
end

def create
  resource = User.new(email: params[:email],password: "password", admin: true)
  if resource.save
    redirect_to "/"
  else
    puts "Not possible"
  end
end

# def savenew
#   rawsql = "insert into users (email, created_at,updated_at) values ('#{user_params[:email]}',now(), now())"
#   sql = rawsql
#   ActiveRecord::Base.connection.execute(sql)
#   redirect_to action: 'index'
# end

def edit
  @user = User.find_by(id: params[:id])
end

def update
  @user = User.find_by(id: params[:id])
  @user.update_attributes(password: params[:password])
  redirect_to "/"
  flash[:success] = "Your password has been updated"
end

end
