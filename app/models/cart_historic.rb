class CartHistoric < ApplicationRecord
  belongs_to :item
  has_many :invoice_temps

end
