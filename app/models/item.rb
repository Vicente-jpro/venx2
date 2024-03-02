class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
  belongs_to :profile
  belongs_to :sector

  has_many :cart_temps
  has_many :cart_historics
  has_many :most_sales

  scope :search_by_item_code_or_description, ->(query) { 
    where("description LIKE '%#{query}%'  OR item_code LIKE '%#{query}%' ")
  }
  
end
