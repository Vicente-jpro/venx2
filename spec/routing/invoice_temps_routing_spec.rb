require "rails_helper"

RSpec.describe InvoiceTempsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/invoice_temps").to route_to("invoice_temps#index")
    end

    it "routes to #new" do
      expect(get: "/invoice_temps/new").to route_to("invoice_temps#new")
    end

    it "routes to #show" do
      expect(get: "/invoice_temps/1").to route_to("invoice_temps#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/invoice_temps/1/edit").to route_to("invoice_temps#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/invoice_temps").to route_to("invoice_temps#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/invoice_temps/1").to route_to("invoice_temps#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/invoice_temps/1").to route_to("invoice_temps#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/invoice_temps/1").to route_to("invoice_temps#destroy", id: "1")
    end
  end
end
