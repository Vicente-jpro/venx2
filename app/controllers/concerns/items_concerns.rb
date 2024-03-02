module ItemsConcerns 
  extend ActiveSupport::Concern
  
  def items_searched(query)
    if query.present?
      @items = Item.search_by_item_code_or_description(query)
    else
      @items = Item.all
    end
    @items
  end

end