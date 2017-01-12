class UserMailer < ApplicationMailer

  default from: "therootsolutions@gmail.com"

  def work_with_us_email(email_object)
    @name = email_object.name
    @user = email_object.email
    @subject = email_object.subject
    @message = email_object.message
    @url = Rails.application.secrets.root_url
    mail(to: "therootsolutions@gmail.com", subject: "#{@name} wants to work with us." )
  end

  def welcome_email_via_admin
    @user = User.last
    root_url = Rails.application.secrets.root_url
    @url = "#{root_url}accounts/#{@user.id}"
    mail(to: "#{@user.email}", subject: "Root Solutions Account Created! ACTION REQUIRED")
  end
end
