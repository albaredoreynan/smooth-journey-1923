FactoryGirl.define do
  factory :item do
    sequence(:name) {|n| "Item#{n}"}
    association :unit
    association :subcategory
  end
end
