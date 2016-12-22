class PagesController < ApplicationController

	layout "pages"

  def about_us
  end

  def work_with_us
  end

  def work_with_us_email
    @name = params[:name]
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]
    UserMailer.work_with_us_email(@name,@email,@subject,@message).deliver_now
  end

  def careers
  end

  def partners
    
  end
  def learn 

  end

end
