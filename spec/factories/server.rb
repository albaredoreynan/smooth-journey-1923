FactoryGirl.define do
  factory :server do
    association :branch
    name 'Server A'
  end
end
