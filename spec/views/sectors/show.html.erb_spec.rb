require 'rails_helper'

RSpec.describe "sectors/show", type: :view do
  before(:each) do
    assign(:sector, Sector.create!(
      name_sector: "Name Sector"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name Sector/)
  end
end
