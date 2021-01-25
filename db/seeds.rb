# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Default user
@mamie = User.find_by_email('mamie@example.com')
if @mamie.nil?
  @mamie = User.create! email: 'mamie@example.com',
                        password: 'kodgo4-rydfEg-turcus'
  @mamie.skip_confirmation!
  @mamie.save!
end