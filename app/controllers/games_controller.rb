class GamesController < ApplicationController

  get '/' do
    json Game.all.as_json
  end
end