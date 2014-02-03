require "spec_helper"

describe Admin::DocumentsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/documents").should route_to("admin/documents#index")
    end

    it "routes to #new" do
      get("/admin/documents/new").should route_to("admin/documents#new")
    end

    it "routes to #show" do
      get("/admin/documents/1").should route_to("admin/documents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/documents/1/edit").should route_to("admin/documents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/documents").should route_to("admin/documents#create")
    end

    it "routes to #update" do
      put("/admin/documents/1").should route_to("admin/documents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/documents/1").should route_to("admin/documents#destroy", :id => "1")
    end

  end
end
