module CartTempsConcerns 
    def item_out_of_stock?(item)
      ( item.quantity - 1 ) == -1
    end 
end