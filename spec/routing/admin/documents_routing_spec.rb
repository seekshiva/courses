require "spec_helper"

describe Admin::DocumentsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/admin/documents")).to route_to("admin/documents#index")
    end

    it "routes to #new" do
      expect(get("/admin/documents/new")).to route_to("admin/documents#new")
    end

    it "routes to #show" do
      expect(get("/admin/documents/1")).to route_to("admin/documents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/admin/documents/1/edit")).to route_to("admin/documents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/admin/documents")).to route_to("admin/documents#create")
    end

    it "routes to #update" do
      expect(put("/admin/documents/1")).to route_to("admin/documents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/admin/documents/1")).to route_to("admin/documents#destroy", :id => "1")
    end

  end
end
