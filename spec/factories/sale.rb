FactoryGirl.define do
  factory :sale do
    vat '1'
    sale_date Date.today
    customer_count '1'
    transaction_count '1'
  end
end
