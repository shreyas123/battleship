class Player < ActiveRecord::Base

has_many :games1, foreign_key: :player1_id, class_name: 'Game', dependent: :destroy
has_many :games2, foreign_key: :player1_id, class_name: 'Game', dependent: :destroy

end