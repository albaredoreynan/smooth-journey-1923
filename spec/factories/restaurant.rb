FactoryGirl.define do
  factory :restaurant do
    association :company
    name 'Buffalo Wings'
  end
end
