require 'rails_helper'

RSpec.describe "cart_temps/show", type: :view do
  before(:each) do
    assign(:cart_temp, CartTemp.create!(
      quantity: 2,
      abandoned: false,
      item: nil,
      profile: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
