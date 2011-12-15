FactoryGirl.define do
  factory :supplier do
    association :company
    name 'My supply'
  end
end
