class Item < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
  belongs_to :profile
  belongs_to :sector

  has_many :cart_temps
  has_many :cart_historics

end
