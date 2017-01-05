class PagesController < ApplicationController

	layout "pages"

  def about_us
  end

  def work_with_us
  end

  def work_with_us_email
    email_message = ContactUsEmail.new(email_params)
    if email_message.valid?
      UserMailer.work_with_us_email(@name,@email,@subject,@message).deliver_now
      respond_to do |format|
        format.json { render :json, { :message => "We will get back to you soon!!", status: 200 } }
      end
    else
      respond_to do |format|
        format.json { render :json => { :message => email_message.errors}, status: 422 }
      end
    end
  end

  def careers
  end

  def partners
  end

  def learn
  end

  private

  def email_params
    params.permit(:name, :email, :subject, :message)
  end
end
