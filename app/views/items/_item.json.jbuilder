json.extract! item, :id, :quantity, :category, :itemType, :size, :created_at, :updated_at
json.url item_url(item, format: :json)
