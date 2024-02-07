require 'rails_helper'

RSpec.describe "suppliers/show", type: :view do
  before(:each) do
    assign(:supplier, Supplier.create!(
      name_supplier: "Name Supplier",
      whatsapp: "Whatsapp",
      telephone: "Telephone",
      address: nil,
      profile: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name Supplier/)
    expect(rendered).to match(/Whatsapp/)
    expect(rendered).to match(/Telephone/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
