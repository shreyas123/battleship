FactoryGirl.define do
  factory :game do
    started_at { Time.now }
    player1 { create(:player) }
    player2 { create(:player) }
  end
end