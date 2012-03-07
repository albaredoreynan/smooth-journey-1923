FactoryGirl.define do
  factory :sale_category do
    association :restaurant
    name 'Category S'
  end
end
