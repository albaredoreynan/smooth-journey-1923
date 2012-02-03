FactoryGirl.define do
  factory :purchase_item do
    association :purchase
    unit_id { FactoryGirl.create(:unit).id }
    item_id { FactoryGirl.create(:item, :unit_id => unit_id).id }
    vat_type 'VAT-Exempted'
    amount 1
    quantity 1
  end
end
