#create sample admin user

admin = User.new
admin.email = 'admin@admin.com'
admin.password = 'password'
admin.password_confirmation = 'password'
admin.save!






# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
