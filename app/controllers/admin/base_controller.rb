class Admin::BaseController < ApplicationController
  layout "admin"

  before_filter do
    redirect_to root_path unless @user && @user.admin?
  end

end
