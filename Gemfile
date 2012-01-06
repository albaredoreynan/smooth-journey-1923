require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'

gem 'rails'
gem 'pg'
gem 'rake'
gem 'devise'
gem 'client_side_validations'
gem 'execjs'
gem 'haml-rails'
gem 'simple_form'
gem 'jquery-rails'
gem 'tabs_on_rails'
gem 'heroku'
gem 'kaminari'
if HOST_OS =~ /linux/i
  gem 'therubyracer'
end

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'web-app-theme'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'spork', '> 0.9.0.rc'
  gem 'guard-rspec'
  gem 'guard-spork'
end

case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end
