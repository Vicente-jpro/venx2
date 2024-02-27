class MostSale < ApplicationRecord
  belongs_to :item

  scope :find_most_sales, -> { self.all.order(quantity) }
  # Ex:- scope :active, -> {where(:active => true)}

  private

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

    scope :find_hundred_items, -> { select(:item_id).distinct.limit(100) }
    
    scope :find_sum_of_an_item, ->(item_id) { 
    select(:item_id).distinct
                    .where(item_id: item_id)
                    .sum(:quantity)
  }
    
end
