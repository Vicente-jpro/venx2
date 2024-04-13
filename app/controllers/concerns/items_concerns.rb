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


  def is_csv_or_ods_file?(content_type)
    ("ods" == content_type) || ("csv" == content_type)
  end
  
end