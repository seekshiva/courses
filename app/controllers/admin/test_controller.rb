class Admin::TestController < Admin::BaseController
  # GET /test
  # GET /test.json
  def index
    @test = Object.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {} }
    end
  end

  # POST /test
  # POST /test.json
  def create
    flash[:notice_type] = "alert-success"
    flash[:notice] = 'Mail was sent successfully'
    begin
      UserMailer.test_email(params[:username]+"@nitt.edu").deliver
    rescue => msg
      flash[:notice] = 'Mail failed'+msg.inspect
      flash[:notice_type] = "alert-danger"
    end
    
    respond_to do |format|
      format.html { redirect_to admin_tests_url }
      format.json { render json: {} }
    end
  end

end
