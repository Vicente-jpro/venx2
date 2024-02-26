class CartSaved < ApplicationRecord
  belongs_to :item
  belongs_to :profile

  def self.total_cost(cart_saved)
    CartSaved.joins("JOIN items ON items.id = cart_saveds.item_id")
    .where(code_cart: cart_saved.code_cart)
            .sum("price*cart_saveds.quantity")
            
  end


  # def self.find_by_current_user(user)
  #   CartSaved.joins(:item, :profile)
  #           .where(profile_id: user.profile.id)
  # end

  def self.find_by_cart_saved(cart_saved) 
    CartSaved.joins(:item, :profile)
             .where(code_cart: cart_saved.code_cart)
  end

  scope :destroy_by_user, ->(user) { where(profile_id: user.profile.id).destroy_all}
  scope :destroy_by_code_cart, ->(cart_saved) { where(code_cart: cart_saved.code_cart).destroy_all}

  
end
