class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :password, confirmation: true
  # after_create :send_welcome_email

  # def send_welcome_email
  #   UserMailer.welcome_email(email_address).deliver_later
  # end
end
