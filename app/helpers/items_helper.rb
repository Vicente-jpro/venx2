module ItemsHelper
    def add_new_item_to_cart_temp(item)
        cart = CartTemp.new
        cart.item = item
        cart
    end
end
