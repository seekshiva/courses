class UserMailer < ActionMailer::Base
  default from: "support@courseshub.in"

  def welcome_email(user)
    @user = user
    @host = "http://courseshub.in/"
    @faculty = nil
    if !@user.is_student?
      @faculty = Faculty.where( user_id: @user.id ).first
    end
    mail(to: "#{@user.name} <#{@user.email}@nitt.edu>", subject: "Welcome to Courseshub")
  end
end
