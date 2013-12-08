class Admin::BaseController < ApplicationController
  layout "admin"

  before_filter do
    redirect_to root_path unless current_user && current_user.admin == true
  end

end
