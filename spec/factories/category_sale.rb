FactoryGirl.define do
  factory :category_sale do
    association :category
    amount 1
  end
end
