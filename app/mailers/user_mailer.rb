class UserMailer < ApplicationMailer

  default from: "info@therootsolutions.org"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Root Solutions")
  end
end
