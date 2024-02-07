require 'rails_helper'

RSpec.describe "items/show", type: :view do
  before(:each) do
    assign(:item, Item.create!(
      name_item: "Name Item",
      quantity: 2,
      price: "9.99",
      tax: "9.99",
      item_code: "Item Code",
      profite_value: "9.99",
      supplier: nil,
      category: nil,
      profile: nil,
      sector: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name Item/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Item Code/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
