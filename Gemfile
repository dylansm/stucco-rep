#ruby=ruby-2.0.0-p0
#ruby-gemset=adoberep

source 'https://rubygems.org'

gem 'rails', '4.0.0.rc1'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'pg'
gem 'puma'
gem 'capistrano'
gem 'rvm-capistrano'
gem 'capistrano_colors'
gem 'nokogiri', "~> 1.5.9"
gem 'fb_graph'
gem 'aws-sdk'
gem 'devise', "~> 3.0.0rc"
gem 'formtastic'
gem 'haml-rails'

group :assets do
  gem 'coffee-rails', '~> 4.0.0'
  gem 'sass-rails', '~> 4.0.0.rc1'
  gem 'uglifier', '>= 1.3.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'wirb'
  gem 'debugger'
  gem 'rspec-rails', "~> 2.0"
  gem 'guard-rspec', "~> 2.5.0"
  gem 'spork-rails', github: 'railstutorial/spork-rails'
  gem 'guard-spork', "~> 1.5.0"
end

group :test do
  gem 'selenium-webdriver', '2.0'
  gem 'capybara', "~> 2.1.0"
  gem 'rb-fsevent'
  #gem 'growl'
end
