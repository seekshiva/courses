ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "courseshub.in",
  :user_name            => "support@courseshub.in",
  :password             => "<my little secret>",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true