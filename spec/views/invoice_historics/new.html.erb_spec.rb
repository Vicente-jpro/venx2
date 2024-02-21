require 'rails_helper'

RSpec.describe "invoice_historics/new", type: :view do
  before(:each) do
    assign(:invoice_historic, InvoiceHistoric.new(
      cliente_name: "MyString",
      total: "9.99",
      sub_total: "9.99",
      value_delivered_customer: "9.99",
      customer_change: "9.99",
      payment_method: "MyString",
      profile: nil,
      cart_historic: nil
    ))
  end

  it "renders new invoice_historic form" do
    render

    assert_select "form[action=?][method=?]", invoice_historics_path, "post" do

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
