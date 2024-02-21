require 'rails_helper'

RSpec.describe "invoice_historics/index", type: :view do
  before(:each) do
    assign(:invoice_historics, [
      InvoiceHistoric.create!(
        cliente_name: "Cliente Name",
        total: "9.99",
        sub_total: "9.99",
        value_delivered_customer: "9.99",
        customer_change: "9.99",
        payment_method: "Payment Method",
        profile: nil,
        cart_historic: nil
      ),
      InvoiceHistoric.create!(
        cliente_name: "Cliente Name",
        total: "9.99",
        sub_total: "9.99",
        value_delivered_customer: "9.99",
        customer_change: "9.99",
        payment_method: "Payment Method",
        profile: nil,
        cart_historic: nil
      )
    ])
  end

  it "renders a list of invoice_historics" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Cliente Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Payment Method".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
