class Admin::BaseController < ApplicationController
  layout "admin"

  before_filter do
    if @user.nil?
      redirect_to login_path
    elsif not @user.admin?
      redirect_to root_path
    end
  end

end
