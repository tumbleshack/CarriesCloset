# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Create Default user
@test = User.find_by_email('test@example.com')
@test = User.create!(email: 'test@example.com',
                     password: 'secure-password') if @test.nil?

@default = User.find_by_email('carrie.closets@gmail.com')
@default = User.create!(email: 'carrie.closets@gmail.com', password: 'GmM$}$X?fb!?+6&(', admin: true) if @default.nil?

categories = [ "Boys'", "Girls'", "Women's", "Men's", "Hygiene Products" ]
categories.each do |category|
  Category.create!(name: category) if Category.find_by_name(category).nil?
end

@admin = User.find_by_email('carries.closet.confirmations@gmail.com')
@admin = User.create!(email: 'carries.closet.confirmations@gmail.com', password: 'admin-password',
                      admin: true) if @admin.nil?

@someitem = Item.find_by_itemType("Shoes")
@someitem = Item.create!(quantity: 2, category: Category.find_by_name(categories.first), itemType: "Shoes", size: "6") if @someitem.nil?

@volunteer = User.find_by_email('carries.closet.volunteer@gmail.com')
@volunteer = User.create!(email: 'carries.closet.volunteer@gmail.com', password: 'volunteer-password',
                          volunteer: true) if @volunteer.nil?

loop do |index|
  break if Request.count >= 10 || Rails.env.production?

  request = Request.new relationship: Request::RELATIONSHIPS.values.sample,
                        full_name: Faker::Name.name,
                        urgency: Request::URGENCIES.values.sample,
                        email: Faker::Internet.email,
                        availability: 1,
                        county: Request::COUNTIES.values.sample,
                        meet: 1,
                        phone: (678_555_0000...678_567_9999).to_a.sample.to_s,
                        status: [ 0, 2 ].sample

  (1...10).to_a.sample.times do
    category = categories.sample
    change = request.item_changes.new category: Category.find_by_name(category),
                                      change_type: 1,
                                      quantity: (1...20).to_a.sample,
                                      itemType: Item.all.pluck(:itemType).sample,
                                      size: %w[ XS S M L XL XXL ].sample
    change.save!
  end

  puts "Request #{index} created: '#{request.full_name}' requests \n- " +
         "#{request.item_changes.map(&:description).join("\n- ")}'" if request.save
end

loop do |index|
  break if Request.count >= 10 || Rails.env.production?

  request = Request.new relationship: Request::RELATIONSHIPS.values.sample,
                        full_name: Faker::Name.name,
                        urgency: Request::URGENCIES.values.sample,
                        email: Faker::Internet.email,
                        availability: 1,
                        county: Request::COUNTIES.values.sample,
                        meet: 1,
                        phone: (678_555_0000...678_567_9999).to_a.sample.to_s

  (1...10).to_a.sample.times do
    category = categories.sample
    change = request.item_changes.new category: Category.find_by_name(category),
                                      change_type: 1,
                                      quantity: (1...20).to_a.sample,
                                      itemType: Item.all.pluck(:itemType).sample,
                                      size: %w[ XS S M L XL XXL ].sample
    change.save!
  end

  if request.save
    puts "Request #{index} created"
    puts " - Items requested: #{request.item_changes.count}"
    puts "   - " + request.item_changes.map(&:description).join("\n   - ")
  end
end
