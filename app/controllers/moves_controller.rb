class MovesController < ApplicationController
  helpers ApplicationHelper

  helpers do

  end

  get '/games/:game_id' do
    game(params[:game_id])
    json @game.moves.all.as_json
  end

  post '/games/:game_id' do
    game(params[:game_id])
    move = @game.moves.new(params[:moves])
    if move.save
      json move
    else
      halt 422, json(move.errors)
    end
  end
end
