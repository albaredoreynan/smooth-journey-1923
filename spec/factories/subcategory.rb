FactoryGirl.define do
  factory :subcategory do
    name 'ab'
    association :category
  end
end
