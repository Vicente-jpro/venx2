module CartSavedsConcerns 
  extend ActiveSupport::Concern
  
  def cart_saved_build(cart, profile, code)
    cart_saved = CartSaved.new
    cart_saved.item = cart.item
    cart_saved.quantity = cart.quantity
    cart_saved.abandoned = true
    cart_saved.code_cart = code
    cart_saved.profile = profile
    cart_saved
  end

  def cart_recovered_build(cart, profile)
    cart_temp = CartTemp.new
    cart_temp.item = cart.item
    cart_temp.quantity = cart.quantity
    cart_temp.abandoned = false
    cart_temp.profile = profile
    cart_temp
  end

end