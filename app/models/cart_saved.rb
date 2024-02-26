class CartSaved < ApplicationRecord
  belongs_to :item
  belongs_to :profile
end
