class InvoiceHistoric < ApplicationRecord
  belongs_to :profile
  belongs_to :cart_historic

  def self.find_by_cart_historic(invoice_historic) 
    InvoiceHistoric.joins(:cart_historic)
                   .where("cart_historics.code_cart = #{invoice_historic.cart_historic.code_cart}")
  end

end
