FactoryGirl.define do
  factory :purchase_item do
    association :purchase
    association :item
    association :unit
    vat_type 'VAT-Exempted'
    amount 1
    quantity 1
  end
end
