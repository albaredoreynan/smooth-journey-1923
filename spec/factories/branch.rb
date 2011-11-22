FactoryGirl.define do
  factory :branch do
    association :restaurant
    location 'Ortigas'
  end
end
