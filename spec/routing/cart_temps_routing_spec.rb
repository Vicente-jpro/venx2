require "rails_helper"

RSpec.describe CartTempsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cart_temps").to route_to("cart_temps#index")
    end

    it "routes to #new" do
      expect(get: "/cart_temps/new").to route_to("cart_temps#new")
    end

    it "routes to #show" do
      expect(get: "/cart_temps/1").to route_to("cart_temps#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/cart_temps/1/edit").to route_to("cart_temps#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/cart_temps").to route_to("cart_temps#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/cart_temps/1").to route_to("cart_temps#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cart_temps/1").to route_to("cart_temps#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/cart_temps/1").to route_to("cart_temps#destroy", id: "1")
    end
  end
end
