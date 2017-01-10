class UserMailer < ApplicationMailer

  default from: "therootsolutions@gmail.com"

  def work_with_us_email(email_object)
    @name = email_object.name
    @user = email_object.email
    @subject = email_object.subject
    @message = email_object.message
    @url = "https:localhost:3000"
    mail(to: "therootsolutions@gmail.com", subject: "#{@name} wants to work with us." )
  end

  def welcome_email_via_admin
    @user = User.last
    @url = "http://localhost:3000/admins/users/#{@user.id}"
    mail(to: "#{@user.email}", subject: "Update your root solutions password")
  end
end
