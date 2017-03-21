class Game < ActiveRecord::Base

  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'

  validates :player1, :player2, :started_at, presence: true

  def serializable_hash(options = {})
    super(
        include: [:player1, :player2]
      )
  end

end