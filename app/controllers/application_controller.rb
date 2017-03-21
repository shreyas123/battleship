class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  before do
    content_type :json
  end

  get '/' do
  end
end