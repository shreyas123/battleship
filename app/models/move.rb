require_relative './placement'

class Move < ActiveRecord::Base

  belongs_to :game

  has_many :placements, through: :game

  validates :game_id, presence: true
  validates :player_number, inclusion: { in: [1,2] }, presence: true
  validates :vertical_move, presence: true, inclusion: { in: Placement::VERTICAL_NAMES }, uniqueness: { scope: [:horizontal_move, :game_id, :player_number] }
  validates :horizontal_move, presence: true, inclusion: { in: Placement::HORIZONTAL_NAMES }, uniqueness: { scope: [:vertical_move, :game_id, :player_number] }

  validate :validate_placements, :validate_game_won, :validate_move

  before_save :check_hit
  after_commit :set_won, :toggle_game_move
  after_commit :set_started_at, if: lambda { game.started_at.nil? }

  private
    def toggle_game_move
      game.toggle_move(player_number)
      true
    end

    def validate_game_won
      if game && !game.won_by.nil?
        errors.add(:player_number, "Game is already won by player #{game.won_by}")
      end
    end

    def validate_move
      if game && game.move != self.player_number
        errors.add(:player_number, "Its player #{game.move} turn")
      end
    end

    def check_hit
      self.hit = false
      if player_number == 2
        self.hit = placements.for_player_1.any? { |placement| placement.placement_board.include?([vertical_move, horizontal_move]) }
      else
        self.hit = placements.for_player_2.any? { |placement| placement.placement_board.include?([vertical_move, horizontal_move]) }
      end
      true
    end

    def set_won
      game.set_won(player_number)
    end

    def validate_placements
      ship_length = Ship.count
      player = []
      player << "player 1" if placements.for_player_1.count != ship_length
      player << "player 2" if placements.for_player_2.count != ship_length
      errors.add(:player_number, "Game cannot start as #{player.join(' and ')} has not placed all the ships.") if player.length > 0
    end

    def set_started_at
      game.set_started_at
    end
end
