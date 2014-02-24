require 'spec_helper'

describe TermsController do

  describe "on GET to #show" do

    context "format: html" do
      before do
        request.env["HTTP_ACCEPT"] = "text/html"
        get :show, id: 0
      end
      
      it { should respond_with 200 }
      it { should render_template 'home/dashboard' }
    end

    context "format: json" do
      before do
        FactoryGirl.create(:term)
        request.env["HTTP_ACCEPT"] = "application/json"
        get :show, id: 1
      end
      
      context "if authorized" do
        xit { should respond_with 200 }
      end
      context "if not authorized" do
        it { should respond_with 401 }
      end
    end
  end
end
