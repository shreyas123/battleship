BattleShip Game API [![Code Climate](https://codeclimate.com/github/shreyas123/battleship/badges/gpa.svg)](https://codeclimate.com/github/shreyas123/battleship) [![Test Coverage](https://codeclimate.com/github/shreyas123/battleship/badges/coverage.svg)](https://codeclimate.com/github/shreyas123/battleship/coverage) [![Build Status](https://travis-ci.org/shreyas123/battleship.svg?branch=master)](https://travis-ci.org/shreyas123/battleship)
===========================

This is a sample Sinatra app which provides API to create and play game via API.
This app can be integrated to any 3rd party and it returns JSON response with 200, 422 or 400 status code.

>> SWEEEETTT isn't it :heart:

## What is Battleship game
**Battleship** (also Battleships or Sea Battle) is a guessing game for **two players**. It is played on ruled grids (paper or board) on which the players' fleets of ships (including battleships) are marked. The locations of the fleet are concealed from the other player. Players alternate turns calling "shots" at the other player's ships, and the objective of the game is to destroy the opposing player's fleet.

[Wikipedia](https://en.wikipedia.org/wiki/Battleship_(game))

## Applicaiton architecture

This app is made in Sinatra and has ActiveRecord 5.0.2 gem.
The app has simple get and post request which takes in the parameters and return the JSON values along with the HTTP code.

It has the MVC pattern where the controller handes thes request and Model handles the validation.
All the business logic as of now is in Model and controller just returns the status of your model.

#### Steps to get the app up and running

You can install app and use in the following way

  - Checkout the code.

  - Install ruby 2.3 or greater

  - ```$ bundle install```

  - copy config/database.yml.example to config/database.yml

  - Modify config/database.yml to your needs

  - ```$ rake db:create db:migrate db:seed``` (Thats right... We also have db seed to seed the database with Ships)

  - ```$ shotgun config.ru```

  - DONE.... point your brower to http://localhost:9393/

## What requests can be made ?
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


## Testing
The complete app is througly tested using RSpec.

To check specs please follow the following steps

  - Modify config/database.yml and add test enviornment

  - ```$ RACK_ENV=test rake db:drop db:create db:migrate```

  - ``` bundle exec rspec ```

## TODO

OK... I could not finish somethings as this app was not that small...
Please accept apologies and ofcourse I need to extend more

  - Add join between game and ship so can change ships in future
  - Player sessions and tokens for third party APIs
  - Investigate params permission
  - Check players before creating a game
  - Pausing and Resuming the game ( The schema is already added just needs changes on the validations of the "Move" model )
