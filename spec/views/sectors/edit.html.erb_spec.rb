require 'rails_helper'

RSpec.describe "sectors/edit", type: :view do
  let(:sector) {
    Sector.create!(
      name_sector: "MyString"
    )
  }

  before(:each) do
    assign(:sector, sector)
  end

  it "renders the edit sector form" do
    render

    assert_select "form[action=?][method=?]", sector_path(sector), "post" do

      assert_select "input[name=?]", "sector[name_sector]"
    end
  end
end
