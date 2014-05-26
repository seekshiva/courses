source 'https://rubygems.org'

gem 'rails',               '>= 4.1.1'

# Legacy Rails features, remove me!

gem 'rails-observers'

# protect attributes from mass assignment
gem 'protected_attributes'

# caches_page
gem 'actionpack-page_caching'
gem 'actionpack-action_caching', '>= 1.1.1'

# Session Store

gem 'activerecord-session_store'

# Authentication

gem 'devise'

# Views

gem 'will_paginate',       '~> 3.0'
gem 'bootstrap-sass',      '~> 3.1.1'
gem 'font-awesome-sass',   '~> 4.1.0'

#CSS

gem 'sass-rails',          '~> 4.0'

# Database

gem 'mysql2',              '~> 0.3.16'

# File uploading

gem 'mime-types'
gem 'paperclip',           '~> 4.1.1'

# Javascript/Coffeescript

gem 'execjs'
gem 'jquery-rails',        '~> 3.1.0'
gem 'rails-backbone',      :git => "http://github.com/codebrew/backbone-rails"
gem 'coffee-rails',        '~> 4.0.1'

# Markdown support

gem 'kramdown'

# ISBN Library

gem 'lisbn',               '~> 0.2'

# Compression

gem 'uglifier',            '~> 2.5'

# Static Pages

gem 'high_voltage',        '~> 2.1.0'

# Process queue

gem 'sidekiq'

group :unix_only do # use the default WERrick server on windows
  # Appserver
  gem 'unicorn',             '~> 4.8.3'

  # Javascript/coffeescript
  gem 'therubyracer',        '~> 0.12.1'
end

group :development do
  # Deployment

  gem "capistrano-rails",   '~> 1.1.1'
  gem 'capistrano-rvm',     '~> 0.1.1'
  gem 'capistrano-bundler', '~> 1.1.2'

  # Coffeescript Sourcemap debugging

  gem 'coffee-rails-source-maps'
end

group :test do
  # RSpec (unit tests)
  gem 'shoulda-matchers',  '~> 2.6'

  # Cucumber (integration tests)
  gem 'capybara',          '2.2.1'
  gem 'database_cleaner',  '~> 1.3'

  # Coverage stats
  # Remove link to githubwhen v0.7.1 get available
  gem 'coveralls',           github: 'lemurheavy/coveralls-ruby', require: false

  # Run tests automatically
  gem 'guard-rspec',        '~> 4.2'

  # General helpers
  gem 'factory_girl_rails', '4.4.1'
end

group :development, :test do
  # RSpec (unit tests, some integration tests)
  gem 'rspec-rails',       '~> 2.14'

  # Cucumber (integration tests)
  gem 'cucumber-rails',    '~> 1.4', :require => false

  # Jasmine (client side application tests (JS))
  gem 'jasmine',           '~> 2.0'
end

