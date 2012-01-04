FactoryGirl.define do
  factory :purchase_item do
    association :purchase
    association :item
    amount 1
    quantity 1
    unit_cost 1
  end
end
