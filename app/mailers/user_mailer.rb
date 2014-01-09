class UserMailer < ActionMailer::Base
  default from: "support@courseshub.in"

  def welcome_email(user)
  	@user = user
  	@url = "http://courseshub.in/login"
  	mail(to: "#{@user.name} <me@vignesh.info>", subject: "Welcome to Courseshub")
  end
end
