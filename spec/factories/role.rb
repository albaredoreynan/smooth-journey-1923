FactoryGirl.define do
  factory :role do
    name 'admin'
    association :user
    association :branch
  end
end
