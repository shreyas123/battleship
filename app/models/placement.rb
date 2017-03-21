class Placement < ActiveRecord::Base

  VERTICAL_NAMES = ('A'..'J').to_a
  HORIZONTAL_NAMES = (1..10).to_a

  validates :game_id, :ship_id, :player_number, :vertical_placement, :horizontal_placement, presence: true
  validates :ship_id, uniqueness: { scope: :game_id }
  validates :player_number, inclusion: { in: [1,2] }, uniqueness: { scope: [:vertical_placement, :horizontal_placement, :game_id] }
  validates :vertical_placement, inclusion: { in: VERTICAL_NAMES }
  validates :horizontal_placement, inclusion: { in: HORIZONTAL_NAMES }

end
