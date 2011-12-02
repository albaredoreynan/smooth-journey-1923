FactoryGirl.define do
  factory :item_count do
    association :item
    stock_count 0
    created_at Time.now

    factory :beginning_of_month_count do
      created_at Time.now.beginning_of_month
    end
  end
end
