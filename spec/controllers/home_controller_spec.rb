require 'spec_helper'

describe HomeController do

  describe "#index" do
    before do
      get :index
    end

    it "should return status_code 200" do
      response.code.should == '200'
    end

    it "should render home/dashboard template" do
      response.should render_template("home/dashboard")
    end
  end

  describe "#me" do
    before do
      get :me
    end

    context "user not logged in" do
      it "should redirect user to login_path" do
        pending
        response.should be_redirect
      end
    end

    pending
  end

  describe "#authenticate" do
    before do
      post :authenticate
    end
    
    pending
  end

end
