ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "courseshub.in",
  :user_name            => "support",
  :password             => "password",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?