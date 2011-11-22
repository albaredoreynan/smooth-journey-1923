FactoryGirl.define do
  factory :supplier do
    association :branch
    name 'My supply'
  end
end
