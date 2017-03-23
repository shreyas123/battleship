FactoryGirl.define do
  factory :move do
    game
    ship_sunk { create :ship }
    player_number { 1 }
  end
end