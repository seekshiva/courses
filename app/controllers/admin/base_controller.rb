class Admin::BaseController < ApplicationController
  layout "admin"
  
  # before filter :require admin user
end
