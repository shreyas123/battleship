require "sinatra"
require "sinatra/json"
require "rubygems"
require "bundler"
require "bundler/setup"
require "sinatra/activerecord"



Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

require "active_support/deprecation"
require "active_support/all"

Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
