require 'rails_helper'

RSpec.describe "suppliers/new", type: :view do
  before(:each) do
    assign(:supplier, Supplier.new(
      name_supplier: "MyString",
      whatsapp: "MyString",
      telephone: "MyString",
      address: nil,
      profile: nil
    ))
  end

  it "renders new supplier form" do
    render

    assert_select "form[action=?][method=?]", suppliers_path, "post" do

      assert_select "input[name=?]", "supplier[name_supplier]"

      assert_select "input[name=?]", "supplier[whatsapp]"

      assert_select "input[name=?]", "supplier[telephone]"

      assert_select "input[name=?]", "supplier[address_id]"

      assert_select "input[name=?]", "supplier[profile_id]"
    end
  end
end
