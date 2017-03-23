FactoryGirl.define do
  factory :move do
    game
    player_number { 1 }
    horizontal_move 1
    vertical_move 'A'
  end
end