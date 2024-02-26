json.extract! cart_saved, :id, :quantity, :abandoned, :item_id, :profile_id, :created_at, :updated_at
json.url cart_saved_url(cart_saved, format: :json)
