class PlayersController < ApplicationController

  get '/' do
    json Player.all
  end

  post '/' do
    player = Player.new(params[:player])
    if player.save
      json player
    else
      halt 422, json(player.errors)
    end
  end
end
