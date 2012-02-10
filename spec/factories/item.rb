FactoryGirl.define do
  factory :item do
    sequence(:name) {|n| "Item#{n}"}
    association :unit
    association :subcategory
    non_inventory false
  end
end
