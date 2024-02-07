require 'rails_helper'

RSpec.describe "invoice_temps/show", type: :view do
  before(:each) do
    assign(:invoice_temp, InvoiceTemp.create!(
      cliente_name: "Cliente Name",
      total: "9.99",
      value_delivered_customer: "Value Delivered Customer",
      customer_change: "9.99",
      payment_method: "Payment Method",
      code_cart: "Code Cart",
      profile: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Cliente Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Value Delivered Customer/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Payment Method/)
    expect(rendered).to match(/Code Cart/)
    expect(rendered).to match(//)
  end
end
