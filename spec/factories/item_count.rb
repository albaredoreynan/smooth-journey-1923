FactoryGirl.define do
  factory :item_count do
    association :item
    association :endcount
    beginning_count 0
    end_count 0
  end
end
