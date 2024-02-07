require 'rails_helper'

RSpec.describe "suppliers/index", type: :view do
  before(:each) do
    assign(:suppliers, [
      Supplier.create!(
        name_supplier: "Name Supplier",
        whatsapp: "Whatsapp",
        telephone: "Telephone",
        address: nil,
        profile: nil
      ),
      Supplier.create!(
        name_supplier: "Name Supplier",
        whatsapp: "Whatsapp",
        telephone: "Telephone",
        address: nil,
        profile: nil
      )
    ])
  end

  it "renders a list of suppliers" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name Supplier".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Whatsapp".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Telephone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
