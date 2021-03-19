json.extract! request, :id, :urgency, :full_name, :email, :phone, :relationship, :county, :meet, :address, :availability, :item_changes, :comments, :created_at, :updated_at
json.url request_url(request, format: :json)
