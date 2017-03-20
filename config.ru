require ::File.expand_path('../config/environment', __FILE__)

map('/games') { run GamesController }
run ApplicationController