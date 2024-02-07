require 'rails_helper'

RSpec.describe "suppliers/edit", type: :view do
  let(:supplier) {
    Supplier.create!(
      name_supplier: "MyString",
      whatsapp: "MyString",
      telephone: "MyString",
      address: nil,
      profile: nil
    )
  }

  before(:each) do
    assign(:supplier, supplier)
  end

  it "renders the edit supplier form" do
    render

    assert_select "form[action=?][method=?]", supplier_path(supplier), "post" do

      assert_select "input[name=?]", "supplier[name_supplier]"

      assert_select "input[name=?]", "supplier[whatsapp]"

      assert_select "input[name=?]", "supplier[telephone]"

      assert_select "input[name=?]", "supplier[address_id]"

      assert_select "input[name=?]", "supplier[profile_id]"
    end
  end
end
