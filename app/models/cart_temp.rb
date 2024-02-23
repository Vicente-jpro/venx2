class CartTemp < ApplicationRecord
  belongs_to :item
  belongs_to :profile

  validates :quantity, presence: true, comparison: { greater_than_or_equal_to: 1 } 

  def self.total_cost 
    CartTemp.joins("JOIN items ON items.id = cart_temps.item_id")
            .sum("price*cart_temps.quantity")
  end

  def self.find_by_current_user(user)
    CartTemp.where(profile_id: user.profile.id)
  end

end
