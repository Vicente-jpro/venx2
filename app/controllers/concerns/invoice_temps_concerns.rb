module InvoiceTempsConcerns
    extend ActiveSupport::Concern

  def cart_historic_build(cart, code, profile)
    cart_historic = CartHistoric.new
    cart_historic.item = cart.item
    cart_historic.quantity = cart.quantity
    cart_historic.abandoned = false
    cart_historic.code_cart = code
    cart_historic.profile = profile
    cart_historic
  end


  def invoice_temp_build(invoice_temp, profile, value_delivered_customer, total_cost, cart_historic, cart )
    @invoice_temp = InvoiceTemp.new
    @invoice_temp.cliente_name = invoice_temp.cliente_name
    @invoice_temp.value_delivered_customer = invoice_temp.value_delivered_customer
    @invoice_temp.payment_method = invoice_temp.payment_method 
    @invoice_temp.profile = profile
    @invoice_temp.total = @total_cost
    @invoice_temp.customer_change = value_delivered_customer - @total_cost
    @invoice_temp.cart_historic = CartHistoric.find_by_cart_historic(cart_historic, profile)
    @invoice_temp.sub_total = cart.quantity * cart.item.price
    @invoice_temp
  end
end
