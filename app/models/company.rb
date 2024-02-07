class Company < ApplicationRecord
  belongs_to :address
  accepts_nested_attributes_for :address, allow_destroy: true

  has_one_attached :image
end
