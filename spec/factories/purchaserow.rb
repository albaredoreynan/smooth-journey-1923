FactoryGirl.define do
  factory :purchaserow do
    association :item
    amount 1
    quantity 1
    unit_cost 1
    vat_type 1
  end
end
