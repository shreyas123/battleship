class MovesController < ApplicationController
  helpers ApplicationHelper

  helpers do

  end

  get '/games/:game_id' do
    game(params[:game_id])
    json @game.moves.all.as_json
  end
end