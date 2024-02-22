class CartHistoric < ApplicationRecord
  belongs_to :item
  belongs_to :profile

  has_many :invoice_temps

  def self.find_by_cart_historic(cart_historic, profile)
     CartHistoric.where(
      item_id: cart_historic.item.id, 
      code_cart: cart_historic.code_cart,
      profile_id: profile.id
    ).take
  end     

  def self.find_last_by_profile(profile)
    CartHistoric.joins(:profile)
                .where("profiles.id = #{profile.id}")
                .order("cart_historics.id")
                .last
  end

end
