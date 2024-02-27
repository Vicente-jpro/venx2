class CartHistoric < ApplicationRecord
  belongs_to :item
  belongs_to :profile

  has_many :invoice_temps, dependent: :destroy
  has_many :invoice_historics, dependent: :destroy

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

  def self.total_cost(cart_historic)
    CartHistoric.joins("JOIN items ON items.id = cart_historics.item_id")
    .where(code_cart: cart_historic.code_cart)
            .sum("price*cart_historics.quantity")
            
  end

  def self.find_hundred_items_with_quantity
    items = find_hundred_items
    tamanho = find_hundred_items.size - 1
    
    while tamanho >= 0
      item_id = items[tamanho].item_id
      quantity = find_sum_of_an_item(item_id)
      
      most_sale = MostSale.new 

      item = Item.new 
      item.id = item_id

      most_sale.item = item
      most_sale.quantity = quantity
      most_sale.save
      tamanho -=1
    end

  end

  private
   scope :find_hundred_items, -> { select(:item_id).distinct.limit(100) }
   
   scope :find_sum_of_an_item, ->(item_id) { 
    select(:item_id).distinct
                    .where(item_id: item_id)
                    .sum(:quantity)
  }
end
