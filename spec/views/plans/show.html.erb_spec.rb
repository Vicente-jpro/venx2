require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    assign(:plan, Plan.create!(
      company: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
