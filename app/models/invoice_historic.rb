class InvoiceHistoric < ApplicationRecord
  max_paginates_per 20
  attr_accessor :year
  
  belongs_to :profile
  belongs_to :cart_historic

  def self.find_by_cart_historic(invoice_historic) 
    InvoiceHistoric.joins(:cart_historic)
                   .where("cart_historics.code_cart = #{invoice_historic.cart_historic.code_cart}")
  end


  enum year: { um_ano: 1, dois_anos: 2, tres_anos: 3, quatro_anos: 4, sinco_anos: 5 }

  scope :search_by_date, ->(data_inicio, data_fim) { 
    where(created_at: (data_inicio)..data_fim)
  }
end
