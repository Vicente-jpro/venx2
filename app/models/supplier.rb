class Supplier < ApplicationRecord
  belongs_to :profile
  belongs_to :address
  accepts_nested_attributes_for :address, allow_destroy: true

  has_many :items
end
