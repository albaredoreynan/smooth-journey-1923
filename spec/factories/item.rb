FactoryGirl.define do
  factory :item do
    sequence(:name) {|n| "Item#{n}"}
    association :unit
  end
end
