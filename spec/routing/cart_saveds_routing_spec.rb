require "rails_helper"

RSpec.describe CartSavedsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cart_saveds").to route_to("cart_saveds#index")
    end

    it "routes to #new" do
      expect(get: "/cart_saveds/new").to route_to("cart_saveds#new")
    end

    it "routes to #show" do
      expect(get: "/cart_saveds/1").to route_to("cart_saveds#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/cart_saveds/1/edit").to route_to("cart_saveds#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/cart_saveds").to route_to("cart_saveds#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/cart_saveds/1").to route_to("cart_saveds#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cart_saveds/1").to route_to("cart_saveds#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/cart_saveds/1").to route_to("cart_saveds#destroy", id: "1")
    end
  end
end
