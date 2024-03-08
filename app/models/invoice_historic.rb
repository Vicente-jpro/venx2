class InvoiceHistoric < ApplicationRecord
  max_paginates_per 20
  belongs_to :profile
  belongs_to :cart_historic

  def self.find_by_cart_historic(invoice_historic) 
    InvoiceHistoric.joins(:cart_historic)
                   .where("cart_historics.code_cart = #{invoice_historic.cart_historic.code_cart}")
  end

  scope :search_by_date, ->(data_inicio, data_fim) { 
    where(created_at: (data_inicio)..data_fim)
  }
end
