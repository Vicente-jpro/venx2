require 'rails_helper'

RSpec.describe "invoice_temps/new", type: :view do
  before(:each) do
    assign(:invoice_temp, InvoiceTemp.new(
      cliente_name: "MyString",
      total: "9.99",
      value_delivered_customer: "MyString",
      customer_change: "9.99",
      payment_method: "MyString",
      code_cart: "MyString",
      profile: nil
    ))
  end

  it "renders new invoice_temp form" do
    render

    assert_select "form[action=?][method=?]", invoice_temps_path, "post" do

      assert_select "input[name=?]", "invoice_temp[cliente_name]"

      assert_select "input[name=?]", "invoice_temp[total]"

      assert_select "input[name=?]", "invoice_temp[value_delivered_customer]"

      assert_select "input[name=?]", "invoice_temp[customer_change]"

      assert_select "input[name=?]", "invoice_temp[payment_method]"

      assert_select "input[name=?]", "invoice_temp[code_cart]"

      assert_select "input[name=?]", "invoice_temp[profile_id]"
    end
  end
end
