require 'spec_helper'

describe RegistrationsController do

  describe "GET to #new" do
    before do
      get :new
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

  describe "POST to #create" do
    pending
  end

end
