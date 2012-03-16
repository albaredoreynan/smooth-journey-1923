FactoryGirl.define do
  factory :settlement_type_sale do
    association :settlement_type
    association :sale
    amount 1
  end
end
