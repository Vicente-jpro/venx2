json.extract! item, :id, :name_item, :manufacturing_date, :expiration_date, :quantity, :price, :tax, :item_code, :profite_value, :supplier_id, :category_id, :profile_id, :sector_id, :created_at, :updated_at
json.url item_url(item, format: :json)
