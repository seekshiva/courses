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

end
