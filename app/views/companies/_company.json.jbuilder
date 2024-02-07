json.extract! company, :id, :name, :image, :address_id, :created_at, :updated_at
json.url company_url(company, format: :json)
json.image url_for(company.image)
