FactoryGirl.define do
  factory :item_count do
    association :item
    stock_count 0
    entry_date Time.now

    factory :beginning_of_month_count do
      entry_date Time.now.beginning_of_month
    end
  end
end
