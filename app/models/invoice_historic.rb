class InvoiceHistoric < ApplicationRecord
  belongs_to :profile
  belongs_to :cart_historic

  def self.find_by_cart_historic_distinct_by_code_cart 
    InvoiceHistoric.joins(:cart_historic)
                   .select("cart_historics.code_cart")
                   .distinct
  end
end
