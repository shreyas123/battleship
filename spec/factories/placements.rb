FactoryGirl.define do
  factory :placement do
    game_id { create(:game).id }
    ship_id { create(:ship).id }
    player_number { 1 }
    vertical { false }
    vertical_placement { 'A' }
    horizontal_placement { 2 }

    trait :is_vertical do
      vertical { true }
    end
  end
end