require 'spec_helper'

describe HomeController do

  describe "on GET to #index" do
    before do
      get :index
    end

    it { should respond_with 200 }
    it { should render_template 'home/dashboard' }

  end

end
