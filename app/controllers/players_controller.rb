class PlayersController < ApplicationController

  get '/' do
    json Player.all
  end
end