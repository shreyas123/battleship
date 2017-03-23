class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  before do
    content_type :json
  end

  get '/' do
    <<-eos
      get '/games' -> Returns all the games
      post '/games' -> Starts a new game with 2 players
                        params required: {
                                          game: {
                                            *player1_id: player.id
                                            *player2_id: player.id
                                          }
                                        }
      get '/players' -> Returns all players
      post '/players' -> Creates a new player
                        params required: {
                                            player: {
                                              *name: string
                                            }
                                         }
      get '/ships' -> Return all ships
      get '/placements/games/:game_id' -> Return all placements
      post '/placements/games/:game_id' -> Return all ships
                        params required: {
                                            placements: {
                                              *game_id: game.id
                                              *ship_id
                                              *horizontal_placement: integer (accepted values 1 to 10)
                                              *vertical_placement: string (accepted values 'A' to 'J')
                                              *player_number: integer (accepted values '1', '2')
                                              vertical: boolean (default false)
                                            }
                                         }
      put '/placements/games/:game_id/:id' -> Update placement
                        params required: {
                                            placements: {
                                              *game_id: game.id
                                              *ship_id: ship.id
                                              *horizontal_placement: integer (accepted values 1 to 10)
                                              *vertical_placement: string (accepted values 'A' to 'J')
                                              *player_number: integer (accepted values '1', '2')
                                              vertical: boolean (default false)
                                            }
                                         }
      delete '/placements/games/:game_id/:id' -> Deletes the placement to put it again
      get '/moves/games/:game_id' -> Get all the moves for a game
      post '/moves/games/:game_id' -> Creates a move for the player
                        params required: {
                                            moves: {
                                              *game_id: game.id
                                              *horizontal_move: integer (accepted values 1 to 10)
                                              *vertical_move: string (accepted values 'A' to 'J')
                                              *player_number: integer (accepted values '1', '2')
                                            }
                                         }
    eos
  end
end