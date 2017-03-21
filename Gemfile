source 'https://rubygems.org'

ruby '2.3.3'

gem 'sinatra'
gem 'sinatra-contrib', :require => false
gem 'rack'
gem 'activesupport'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'pg'
gem 'rake'

group :development do
  gem 'shotgun'
end

group :development, :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'pry'
end

group :test do
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
end
