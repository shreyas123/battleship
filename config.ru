require ::File.expand_path('../config/environment', __FILE__)

map('/games') { run GamesController }
map('/players') { run PlayersController }
map('/ships') { run ShipsController }
run ApplicationController
