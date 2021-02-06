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
if @mamie.nil?
  @mamie = User.create! email: 'test@example.com',
                        password: 'secure-password'
end

loop do
  break if Request.count >= 10

  @request = Request.create! urgency: (1...Request::URGENCIES.count).to_a.sample,
                             full_name: Faker::Name.name,
                             email: Faker::Internet.email,
                             phone: (678_555_0000...678_567_9999).to_a.sample.to_s,
                             relationship: (1...Request::RELATIONSHIPS.count).to_a.sample,
                             county: (1...Request::COUNTIES.count).to_a.sample,
                             meet: 1,
                             availability: Faker::Lorem.sentence,
                             comments: Faker::Lorem.sentence,
                             items: Faker::Lorem.sentence
  puts "Request #{Request.count}: '#{@request.full_name}' requests '#{@request.items}'"
end
