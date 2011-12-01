FactoryGirl.define do
  factory :item_count do
    association :item
    count 0
    created_at Time.now
  end
end
