require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  let(:item) {
    Item.create!(
      name_item: "MyString",
      quantity: 1,
      price: "9.99",
      tax: "9.99",
      item_code: "MyString",
      profite_value: "9.99",
      supplier: nil,
      category: nil,
      profile: nil,
      sector: nil
    )
  }

  before(:each) do
    assign(:item, item)
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(item), "post" do

      assert_select "input[name=?]", "item[name_item]"

      assert_select "input[name=?]", "item[quantity]"

      assert_select "input[name=?]", "item[price]"

      assert_select "input[name=?]", "item[tax]"

      assert_select "input[name=?]", "item[item_code]"

      assert_select "input[name=?]", "item[profite_value]"

      assert_select "input[name=?]", "item[supplier_id]"

      assert_select "input[name=?]", "item[category_id]"

      assert_select "input[name=?]", "item[profile_id]"

      assert_select "input[name=?]", "item[sector_id]"
    end
  end
end
