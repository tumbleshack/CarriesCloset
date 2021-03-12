json.extract! donation, :id, :full_name, :email, :phone, :county, :meet, :address, :availability, :items, :comments, :created_at, :updated_at
json.url donation_url(donation, format: :json)
