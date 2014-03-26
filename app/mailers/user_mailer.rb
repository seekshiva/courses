class UserMailer < ActionMailer::Base
  default from: "support@courseshub.in"

  def welcome_email(user)
    @user = user
    @host = "http://courseshub.in/"
    @faculty = nil
    if !@user.student?
      @faculty = Faculty.where( user_id: @user.id ).first
    end
    mail(to: "#{@user.name} <#{@user.email}@nitt.edu>", subject: "Welcome to Courseshub")
  end

  def test_email(user)
    @user = user
    @host = "http://courseshub.in/"
    mail(to: "#{@user}", subject: "Testing mail from courseshub")
  end
end
