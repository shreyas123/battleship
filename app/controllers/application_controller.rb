class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
  end
end