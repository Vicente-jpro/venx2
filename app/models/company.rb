class Company < ApplicationRecord
  belongs_to :address
  accepts_nested_attributes_for :address, allow_destroy: true
  
  has_many :profiles 
  has_one_attached :image
  has_one :plan_selected
  has_one :profile
end
