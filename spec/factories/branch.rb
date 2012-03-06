FactoryGirl.define do
  factory :branch do
    association :restaurant
    sequence(:location) { |n| "Branch#{n}" }
  end
end
