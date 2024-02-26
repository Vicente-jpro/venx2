require 'rails_helper'

RSpec.describe "cart_saveds/edit", type: :view do
  let(:cart_saved) {
    CartSaved.create!(
      quantity: 1,
      abandoned: false,
      item: nil,
      profile: nil
    )
  }

  before(:each) do
    assign(:cart_saved, cart_saved)
  end

  it "renders the edit cart_saved form" do
    render

    assert_select "form[action=?][method=?]", cart_saved_path(cart_saved), "post" do

      assert_select "input[name=?]", "cart_saved[quantity]"

      assert_select "input[name=?]", "cart_saved[abandoned]"

      assert_select "input[name=?]", "cart_saved[item_id]"

      assert_select "input[name=?]", "cart_saved[profile_id]"
    end
  end
end
