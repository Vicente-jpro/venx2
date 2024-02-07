require 'rails_helper'

RSpec.describe "invoice_temps/index", type: :view do
  before(:each) do
    assign(:invoice_temps, [
      InvoiceTemp.create!(
        cliente_name: "Cliente Name",
        total: "9.99",
        value_delivered_customer: "Value Delivered Customer",
        customer_change: "9.99",
        payment_method: "Payment Method",
        code_cart: "Code Cart",
        profile: nil
      ),
      InvoiceTemp.create!(
        cliente_name: "Cliente Name",
        total: "9.99",
        value_delivered_customer: "Value Delivered Customer",
        customer_change: "9.99",
        payment_method: "Payment Method",
        code_cart: "Code Cart",
        profile: nil
      )
    ])
  end

  it "renders a list of invoice_temps" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Cliente Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Value Delivered Customer".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Payment Method".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Code Cart".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
