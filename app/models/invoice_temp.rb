class InvoiceTemp < ApplicationRecord
  belongs_to :profile
  belongs_to :cart_historic
 
  enum payment_method: { monetario: "MASCULINO", transferencia: "FEMININO", cartao_de_debito: "CARTAO_DEBITO"}

  def self.find_by_cart_historic(cart_historic)  
    InvoiceTemp.joins(:cart_historic)
              .where("cart_historics.code_cart = #{cart_historic.code_cart}")
  end

  scope :destroy_by_user, ->(user) { where(profile_id: user.profile.id).destroy_all}
  scope :find_by_current_user, ->(user) { where(profile_id: user.profile.id).destroy_all}
end
