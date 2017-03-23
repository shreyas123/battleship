require_relative './placement'

class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :ship_sunk, class_name: 'Ship'

  validates :game_id, :horizontal_move, :vertical_move, presence: true
  validates :vertical_move, inclusion: { in: Placement::VERTICAL_NAMES }, uniqueness: { scope: [:horizontal_move, :game_id] }
  validates :horizontal_move, inclusion: { in: Placement::HORIZONTAL_NAMES }, uniqueness: { scope: [:vertical_move, :game_id] }
end
