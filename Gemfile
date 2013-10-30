#ruby=ruby-2.0.0-p353
#ruby-gemset=adoberep

source 'http://rubygems.org'

gem 'rails', '4.0.0.rc2'
gem 'jquery-rails'
#gem 'turbolinks'
gem 'active_model_serializers'
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
gem 'omniauth'
gem 'omniauth-facebook'
gem 'simple_form', '~> 3.0.0rc'
gem 'coffee-script', :require => 'coffee_script'
gem 'db_populate', github: 'ffmike/db-populate'
gem 'aws-ses', "~> 0.5.0", :require => 'aws/ses'
gem 'kaminari'
gem 'paperclip', github: 'thoughtbot/paperclip'
gem 'ranked-model'
gem 'haml-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'
gem 'execjs'
gem 'bourbon'
gem 'neat'
gem 'modernizr_rails'
gem 'haml'
gem 'ejs'
gem 'haml_coffee_assets', '~> 1.5.1'

group :production, :staging do
  gem "therubyracer", :require => 'v8'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'guard-ctags-bundler'
  gem 'guard-livereload'
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
  gem 'database_cleaner'
  gem 'selenium-webdriver', '2.0'
  gem 'capybara', "~> 2.1.0"
  gem 'rb-fsevent'
  gem "factory_girl_rails", "~> 4.0"
  gem 'shoulda-matchers'
end
