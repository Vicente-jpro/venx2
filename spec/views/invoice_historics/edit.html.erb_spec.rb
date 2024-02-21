require 'rails_helper'

RSpec.describe "invoice_historics/edit", type: :view do
  let(:invoice_historic) {
    InvoiceHistoric.create!(
      cliente_name: "MyString",
      total: "9.99",
      sub_total: "9.99",
      value_delivered_customer: "9.99",
      customer_change: "9.99",
      payment_method: "MyString",
      profile: nil,
      cart_historic: nil
    )
  }

  before(:each) do
    assign(:invoice_historic, invoice_historic)
  end

  it "renders the edit invoice_historic form" do
    render

    assert_select "form[action=?][method=?]", invoice_historic_path(invoice_historic), "post" do

      assert_select "input[name=?]", "invoice_historic[cliente_name]"

      assert_select "input[name=?]", "invoice_historic[total]"

      assert_select "input[name=?]", "invoice_historic[sub_total]"

      assert_select "input[name=?]", "invoice_historic[value_delivered_customer]"

      assert_select "input[name=?]", "invoice_historic[customer_change]"

      assert_select "input[name=?]", "invoice_historic[payment_method]"

      assert_select "input[name=?]", "invoice_historic[profile_id]"

      assert_select "input[name=?]", "invoice_historic[cart_historic_id]"
    end
  end
end
