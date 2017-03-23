class Game < ActiveRecord::Base

  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'

  has_many :placements, dependent: :destroy
  has_many :moves, dependent: :destroy

  validates :player1_id, :player2_id, presence: true

  def serializable_hash(options = {})
    super(
        include: [:player1, :player2]
      )
  end

  def toggle_move(player_number)
    self.move = (player_number == 1 ? 2 : 1)
    self.save!
  end

  def set_won(current_player)
    if Ship.sum(:length) == moves.where(player_number: current_player).count(:hit)
      self.won_by = current_player
      self.save
    end
  end

  def set_started_at
    self.started_at = Time.now
    self.save
  end
end
