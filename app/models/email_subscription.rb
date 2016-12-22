class EmailSubscription < ApplicationRecord
  validates_format_of :email,:with => Devise::email_regexp
  validates :email, uniqueness: true
end
