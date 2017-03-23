require_relative './placement'

class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :ship_sunk, class_name: 'Ship'

  has_many :placements, through: :game

  validates :game_id, presence: true
  validates :player_number, inclusion: { in: [1,2] }, presence: true
  validates :vertical_move, presence: true, inclusion: { in: Placement::VERTICAL_NAMES }, uniqueness: { scope: [:horizontal_move, :game_id] }
  validates :horizontal_move, presence: true, inclusion: { in: Placement::HORIZONTAL_NAMES }, uniqueness: { scope: [:vertical_move, :game_id] }



end
