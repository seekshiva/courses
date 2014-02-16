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

  describe "#getting_started" do
    before do
      get :getting_started
    end

    context "user is not logged in" do
      before do
        sign_out :user
      end

      it "should redirect user to login_path" do
        response.should be_redirect
      end
    end
  end

  describe "#authenticate" do
    before do
      post :authenticate
    end
    
    pending
  end

  describe "#signout" do
    before do
      post :signout
    end
    
    pending
  end

end
