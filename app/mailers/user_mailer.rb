class UserMailer < ApplicationMailer

  default from: "therootsolutions@gmail.com"

  def work_with_us_email(name,email,subject,message)
    @name = name
    @user = email
    @subject = subject
    @message = message
    @url = "https:localhost:3000"
    mail(to: "therootsolutions@gmail.com", subject: "#{@name} wants to work with us." )
  end
end
