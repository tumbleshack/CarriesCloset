json.extract! request, :id, :urgency, :full_name, :email, :phone, :type, :county, :meet, :availability, :comments, :created_at, :updated_at
json.url request_url(request, format: :json)
