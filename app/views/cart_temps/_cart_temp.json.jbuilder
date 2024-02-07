json.extract! cart_temp, :id, :quantity, :abandoned, :item_id, :profile_id, :created_at, :updated_at
json.url cart_temp_url(cart_temp, format: :json)
