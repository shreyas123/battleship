FactoryGirl.define do
  factory :game do
    player1 { create(:player) }
    player2 { create(:player) }
  end
end
