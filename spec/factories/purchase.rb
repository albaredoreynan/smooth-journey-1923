FactoryGirl.define do
  factory :purchase do
    purchase_date Time.now
    association :branch
    association :supplier
    invoice_id 1
  end
end
