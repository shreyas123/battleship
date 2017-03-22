class PlacementsController < ApplicationController

  helpers do
    def game(game_id)
      @game ||= Game.find_by(id: game_id)
      halt 400, json({error: 'Game does not exist'}) unless @game
    end

    def placement(id)
      @placement ||= @game.placements.find_by(id: id)
      halt 400, json({error: 'Placement does not exist'}) unless @placement
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

  put '/games/:game_id/:id' do
    game(params[:game_id])
    placement(params[:id])

    if @placement.update_attributes(params[:placement])
      json @placement
    else
      halt 422, json(@placement.errors)
    end
  end

  delete '/games/:game_id/:id' do
    game(params[:game_id])
    placement(params[:id])

    if @placement.destroy
      json({ success: true })
    else
      halt 422, json(@placement.errors)
    end
  end
end
