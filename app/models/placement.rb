class Placement < ActiveRecord::Base

  belongs_to :game
  belongs_to :ship

  VERTICAL_NAMES = ('A'..'J').to_a
  HORIZONTAL_NAMES = (1..10).to_a

  validates :game_id, :ship_id, :player_number, :vertical_placement, :horizontal_placement, presence: true
  validates :ship_id, uniqueness: { scope: :game_id }
  validates :player_number, inclusion: { in: [1,2] }, uniqueness: { scope: [:vertical_placement, :horizontal_placement, :game_id] }
  validates :vertical_placement, inclusion: { in: VERTICAL_NAMES }
  validates :horizontal_placement, inclusion: { in: HORIZONTAL_NAMES }

  validate :overlap
  validate :overbound

  scope :for_player_1, -> { where(player_number: 1) }
  scope :for_player_2, -> { where(player_number: 2) }

  def overlap
    placements = Placement.where(game: self.game, player_number: self.player_number)
    placements.each do |placement|
      if (placement.placement_board & self.placement_board).length > 0
        errors.add(:ship, 'The placement overlaps with another ship')
        return false
      end
    end
  end

  def overbound
    return false unless ship
    error = false
    if vertical
      error = true if vertical_placement && (vertical_placement.ord + ship.length) > VERTICAL_NAMES.last.ord
    else
      error = true if horizontal_placement && (horizontal_placement + ship.length) > HORIZONTAL_NAMES.last
    end
    if error
      errors.add(:ship, 'The placement overlaps with another ship')
      return false
    end
    return true
  end

  def placement_board
    return [] unless ship
    if vertical
      ship.length.times.map { |k| [(vertical_placement.ord + k).chr, horizontal_placement] }
    else
      ship.length.times.map { |k| [vertical_placement, horizontal_placement + k] }
    end
  end
end
