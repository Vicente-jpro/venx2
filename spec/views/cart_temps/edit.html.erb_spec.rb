require 'rails_helper'

RSpec.describe "cart_temps/edit", type: :view do
  let(:cart_temp) {
    CartTemp.create!(
      quantity: 1,
      abandoned: false,
      item: nil,
      profile: nil
    )
  }

  before(:each) do
    assign(:cart_temp, cart_temp)
  end

  it "renders the edit cart_temp form" do
    render

    assert_select "form[action=?][method=?]", cart_temp_path(cart_temp), "post" do

      assert_select "input[name=?]", "cart_temp[quantity]"

      assert_select "input[name=?]", "cart_temp[abandoned]"

      assert_select "input[name=?]", "cart_temp[item_id]"

      assert_select "input[name=?]", "cart_temp[profile_id]"
    end
  end
end
