require "rails_helper"

RSpec.describe InvoiceHistoricsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/invoice_historics").to route_to("invoice_historics#index")
    end

    it "routes to #new" do
      expect(get: "/invoice_historics/new").to route_to("invoice_historics#new")
    end

    it "routes to #show" do
      expect(get: "/invoice_historics/1").to route_to("invoice_historics#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/invoice_historics/1/edit").to route_to("invoice_historics#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/invoice_historics").to route_to("invoice_historics#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/invoice_historics/1").to route_to("invoice_historics#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/invoice_historics/1").to route_to("invoice_historics#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/invoice_historics/1").to route_to("invoice_historics#destroy", id: "1")
    end
  end
end
