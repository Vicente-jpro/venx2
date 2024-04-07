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

  scope :search_by_date, ->(data_inicio, data_fim) {
    where(created_at: (data_inicio)..data_fim)
  }

end
