class CartTemp < ApplicationRecord
  belongs_to :item
  belongs_to :profile

  validates :quantity, presence: true, comparison: { greater_than_or_equal_to: 1 } 

  def self.total_cost(user) 
    CartTemp.joins("JOIN items ON items.id = cart_temps.item_id")
            .where(profile_id: user.profile.id)
            .sum("price*cart_temps.quantity")
            
  end

  def self.find_by_current_user(user)
    CartTemp.joins(:item, :profile)
            .where(profile_id: user.profile.id)
  end

  def self.find_by_profile(profile)
    CartTemp.joins(:item, :profile)
            .where(profile_id: profile.id)
  end
  
  scope :destroy_by_user, ->(user) { where(profile_id: user.profile.id).destroy_all}

end
