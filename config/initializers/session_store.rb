# Be sure to restart your server when you modify this file.

# Courses::Application.config.session_store :cookie_store, key: '_courses_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Courses::Application.config.session_store :active_record_store, :key => '_courses_session'

ActiveRecord::SessionStore::Session.attr_accessible :data, :session_id

Rails.application.config.middleware.insert_before(
  # ActionController::Session::ActiveRecordStore,
  # ActionDispatch::Session::CookieStore,
  Rails.application.config.session_store,
  FlashsessioncookieMiddleware,
  Rails.application.config.session_options[:key]
)