class HomeController < ApplicationController

  respond_to :html

  # GET /
  # GET /login
  # GET /:slug
  # GET /:slug/*route
  def index
    respond_to do |format|
      format.html { render "home/dashboard" }
    end
  end
  
end
