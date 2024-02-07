require 'rails_helper'

RSpec.describe "cart_temps/new", type: :view do
  before(:each) do
    assign(:cart_temp, CartTemp.new(
      quantity: 1,
      abandoned: false,
      item: nil,
      profile: nil
    ))
  end

  it "renders new cart_temp form" do
    render

    assert_select "form[action=?][method=?]", cart_temps_path, "post" do

      assert_select "input[name=?]", "cart_temp[quantity]"

      assert_select "input[name=?]", "cart_temp[abandoned]"

      assert_select "input[name=?]", "cart_temp[item_id]"

      assert_select "input[name=?]", "cart_temp[profile_id]"
    end
  end
end
