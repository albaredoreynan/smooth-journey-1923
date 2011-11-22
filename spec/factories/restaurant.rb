FactoryGirl.define do
  factory :restaurant do
    store_id 1
    association :company
    name 'Buffalo Wings'
  end
end
