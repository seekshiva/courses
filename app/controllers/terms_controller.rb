class TermsController < ApplicationController

  before_action :require_user

  def show
    respond_to do |format|
      format.html { render "home/dashboard" }
      format.json do
        @term = Term.find(params[:id])
        render json: @term.as_json( current_user: @user )
      end
    end
  end
end
