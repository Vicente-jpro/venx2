class CartSaved < ApplicationRecord
  max_paginates_per 15
  
  belongs_to :item
  belongs_to :profile

  def self.total_cost(cart_saved)
    CartSaved.joins("JOIN items ON items.id = cart_saveds.item_id")
    .where(code_cart: cart_saved.code_cart)
            .sum("price*cart_saveds.quantity")
            
  end


   scope :find_all_by_company, ->(company){ 
      joins(:item, :profile)
      .joins("JOIN companies ON companies.id = profiles.company_id")
      .where("companies.id = #{company.id}") 
   }


  # SELECT * FROM cart_saveds
	# join items
  #   on items.id = cart_saveds.item_id
  #   join profiles
  #   on profiles.id = cart_saveds.profile_id
  #   join companies 
  #   on companies.id = profiles.company_id
  #   where companies.id = 1;

  def self.find_by_cart_saved(cart_saved) 
    CartSaved.joins(:item, :profile)
             .where(code_cart: cart_saved.code_cart)
  end

  scope :destroy_by_user, ->(user) { where(profile_id: user.profile.id).destroy_all}
  scope :destroy_by_code_cart, ->(cart_saved) { where(code_cart: cart_saved.code_cart).destroy_all}

  
end
