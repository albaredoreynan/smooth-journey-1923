FactoryGirl.define do
  factory :item_count do
    association :item
    association :endcount
    begin_count 0
    end_count 0
  end
end
