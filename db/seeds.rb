require 'factory_girl_rails'

#create sample admin user
if User.where(email: 'admin@admin.com').count < 1
admin = User.new
admin.email = 'admin@admin.com'
admin.password = 'password'
admin.password_confirmation = 'password'
admin.save!
end

30.times do |i|
  FactoryGirl.create(:resource)
end



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
