require ::File.expand_path('../config/environment', __FILE__)

map('/games') { run GamesController }
map('/players') { run PlayersController }
map('/ships') { run ShipsController }
map('/placements') { run PlacementsController }
map('/moves') { run MovesController }

run ApplicationController
