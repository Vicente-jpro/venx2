require 'rails_helper'

RSpec.describe "cart_saveds/index", type: :view do
  before(:each) do
    assign(:cart_saveds, [
      CartSaved.create!(
        quantity: 2,
        abandoned: false,
        item: nil,
        profile: nil
      ),
      CartSaved.create!(
        quantity: 2,
        abandoned: false,
        item: nil,
        profile: nil
      )
    ])
  end

  it "renders a list of cart_saveds" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
