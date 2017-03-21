class ShipsController < ApplicationController

  get '/' do
    json Ship.all
  end
end
