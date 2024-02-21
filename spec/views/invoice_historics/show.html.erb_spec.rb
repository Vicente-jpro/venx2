require 'rails_helper'

RSpec.describe "invoice_historics/show", type: :view do
  before(:each) do
    assign(:invoice_historic, InvoiceHistoric.create!(
      cliente_name: "Cliente Name",
      total: "9.99",
      sub_total: "9.99",
      value_delivered_customer: "9.99",
      customer_change: "9.99",
      payment_method: "Payment Method",
      profile: nil,
      cart_historic: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Cliente Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Payment Method/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
