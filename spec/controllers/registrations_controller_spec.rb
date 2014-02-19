require 'spec_helper'

describe RegistrationsController do

  describe "on GET to #new" do
    before do
      get :new
    end

    context "user is not logged in" do
      before do
        sign_out :user
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(login_path) }

    end
  end

  describe "on POST to #create" do
    before do
      post :create
    end

    context "with valid attributes" do
      pending
    end

    context "with invalid attributes" do
      pending
    end
  end

end
