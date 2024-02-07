require 'rails_helper'

RSpec.describe "sectors/index", type: :view do
  before(:each) do
    assign(:sectors, [
      Sector.create!(
        name_sector: "Name Sector"
      ),
      Sector.create!(
        name_sector: "Name Sector"
      )
    ])
  end

  it "renders a list of sectors" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name Sector".to_s), count: 2
  end
end
