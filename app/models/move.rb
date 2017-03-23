class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :ship_sunk, class_name: 'Ship'
end
