class Game < ActiveRecord::Base

  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'

  has_many :placements, dependent: :destroy

  validates :player1_id, :player2_id, presence: true

  before_create :set_started_at

  def serializable_hash(options = {})
    super(
        include: [:player1, :player2]
      )
  end

  private
    def set_started_at
      self.started_at = Time.now
    end

end
