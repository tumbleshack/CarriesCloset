# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Create Default user
@mamie = User.find_by_email('test@example.com')
@mamie = User.create!(email: 'test@example.com',
                      password: 'secure-password') if @mamie.nil?

categories = [ "Boys'", "Girls'", "Women's", "Men's", "Hygiene Products" ]
categories.each do |category|
  Category.create!(name: category) if Category.find_by_name(category).nil?

@admin = User.find_by_email('carries.closet.confirmations@gmail.com')
@admin = User.create!(email: 'carries.closet.confirmations@gmail.com', password: 'admin-password',
                      admin: true) if @admin.nil?

@someitem = Item.find_by_itemType("Shoes")
@someitem = Item.create!(quantity: 2, category: Category.find_by_name(categories.first), itemType: "Shoes", size: "6") if @someitem.nil?

end
