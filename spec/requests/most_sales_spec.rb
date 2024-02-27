require 'rails_helper'

RSpec.describe "MostSales", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/most_sales/index"
      expect(response).to have_http_status(:success)
    end
  end

end
