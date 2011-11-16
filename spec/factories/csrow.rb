FactoryGirl.define do
  factory :csrow do
    association :category
    cs_amount 1
  end
end
