require "sinatra"
require "rubygems"
require "bundler"
require "bundler/setup"


Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

require "active_support/deprecation"
require "active_support/all"

Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
