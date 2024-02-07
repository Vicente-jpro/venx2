require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
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
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

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
