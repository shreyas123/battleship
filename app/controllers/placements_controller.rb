class PlacementsController < ApplicationController

  helpers do
    def game(game_id)
      @game = Game.find_by(id: params[:game_id])
      halt 400, json({error: 'Game does not exist'}) unless @game
    end
  end

  get '/games/:game_id' do
    game(params[:game_id])
    json @game.placements.all.as_json
  end

  post '/games/:game_id' do
    game(params[:game_id])
    placement = @game.placements.new(params[:placement])
    if placement.save
      json placement
    else
      halt 422, json(placement.errors)
    end
  end
end
