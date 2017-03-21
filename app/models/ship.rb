class Ship < ActiveRecord::Base

  validates :name, :length, presence: true

end