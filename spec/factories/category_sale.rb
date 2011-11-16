FactoryGirl.define do
  factory :category_sale do
    association :category
    cs_amount 1
  end
end
