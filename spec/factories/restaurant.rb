FactoryGirl.define do
  factory :restaurant do
    sequence :store_id
    association :company
    name 'Buffalo Wings'
  end
end
