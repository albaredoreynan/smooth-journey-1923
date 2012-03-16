FactoryGirl.define do
  factory :sale do
    association :branch
    vat 0
    sale_date Date.today
    customer_count '1'
    transaction_count '1'
  end
end
