FactoryGirl.define do
  factory :ship do
    sequence(:name) { |n| "Carrier#{n}" }
    length { 5 }
  end
end