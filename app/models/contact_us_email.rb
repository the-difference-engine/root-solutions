class ContactUsEmail
  # include ActiveModel::Model
  include ActiveModel::Validations
  # include ActiveModel::Naming
  # include ActiveModel::Conversion

  attr_accessor :name, :subject, :message, :email

  validates :name, length: { minimum: 2 }
  validates :subject, length: { minimum: 2 }
  validates :message, length: { minimum: 2 }
  # validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_format_of :email,:with => Devise::email_regexp


  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

end