require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'

gem 'rails'
gem 'pg'
gem 'rake'
gem 'devise'
gem 'cancan'
gem 'client_side_validations'
gem 'execjs'
gem 'haml-rails'
gem 'simple_form'
gem 'jquery-rails'
gem 'tabs_on_rails'
gem 'heroku'
gem 'hpricot'
gem 'kaminari'
gem 'prawn'
gem 'prawn-layout'
gem 'paranoia'

group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'factory_girl_rails'
  gem 'ruby_parser'
  gem 'web-app-theme'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
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
