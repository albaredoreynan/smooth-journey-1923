FactoryGirl.define do
  factory :item_count do
    association :item
    count 0
  end
end
