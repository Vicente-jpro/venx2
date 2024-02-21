class InvoiceHistoric < ApplicationRecord
  belongs_to :profile
  belongs_to :cart_historic
end
