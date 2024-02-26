require 'rails_helper'

RSpec.describe "cart_saveds/new", type: :view do
  before(:each) do
    assign(:cart_saved, CartSaved.new(
      quantity: 1,
      abandoned: false,
      item: nil,
      profile: nil
    ))
  end

  it "renders new cart_saved form" do
    render

    assert_select "form[action=?][method=?]", cart_saveds_path, "post" do

      assert_select "input[name=?]", "cart_saved[quantity]"

      assert_select "input[name=?]", "cart_saved[abandoned]"

      assert_select "input[name=?]", "cart_saved[item_id]"

      assert_select "input[name=?]", "cart_saved[profile_id]"
    end
  end
end
