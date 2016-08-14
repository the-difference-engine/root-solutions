class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   after_create :send_welcome_email

   def send_welcome_email
     UserMailer.welcome_email(self).deliver_later
   end
end
