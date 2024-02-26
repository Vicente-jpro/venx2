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

end