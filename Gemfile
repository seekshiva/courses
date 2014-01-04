source 'https://rubygems.org'

gem 'rails',               '>= 4.0.2'

# Legacy Rails features, remove me!

gem 'rails-observers'

# protect attributes from mass assignment
gem 'protected_attributes'

# caches_page
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'

# Appserver

gem 'unicorn',             '>= 4.7'

# Authentication

gem 'devise'

# Views

gem 'will_paginate',       '~> 3.0'
gem 'bootstrap-sass',      '~> 3.0.3.0'
gem 'font-awesome-sass',   '~> 4.0.2'

#CSS

gem 'sass-rails',          '~> 4.0.1'

# Database

gem 'mysql2',              '~> 0.3.14'

# File uploading

gem 'mime-types'
gem 'paperclip',           '~> 3.5.2'

# Javascript/Coffeescript

gem 'execjs'
gem 'jquery-rails'
gem 'therubyracer',        '~> 0.12.0'
gem 'rails-backbone',      '~> 0.9.10'
gem 'coffee-rails',        '~> 4.0.1'

# Markdown support

gem 'bluecloth'

# Compression

gem 'uglifier',            '~> 1.3.0'

group :development do
  # Deployment

  gem "capistrano-rails"
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
end

group :test do
  # Cucumber (integration tests)
  gem 'database_cleaner',  '1.1.0'
end

group :development, :test do
  # RSpec (unit tests, some integration tests)
  gem 'rspec-rails',       '2.14.1'

  # Cucumber (integration tests)
  gem 'cucumber-rails',    '1.4.0', :require => false

  # Jasmine (client side application tests (JS))
  gem 'jasmine',           '2.0.0'
end

