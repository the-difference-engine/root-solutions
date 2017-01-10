class AccountsController < ApplicationController
  before_action :authenticate_user!
  
def new
end

def create
  resource = User.new(email: params[:email],password: params[:password], admin: false)
  if current_user.admin
    resource.save
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

end
