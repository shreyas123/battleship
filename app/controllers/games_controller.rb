class GamesController < ApplicationController

  get '/' do
    json Game.includes(:player1, :player2).all.as_json
  end

  post '/' do
    game = Game.new(player1_id: params[:game][:player1_id], player2_id: params[:game][:player2_id])
    if game.save
      json game
    else
      halt 422, json(game.errors)
    end
  end
end
