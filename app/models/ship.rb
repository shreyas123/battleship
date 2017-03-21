class Ship < ActiveRecord::Base

  validates :name, uniqueness: true
  validates :name, :length, presence: true
  validates :length, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }

end