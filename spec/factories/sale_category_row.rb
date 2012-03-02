FactoryGirl.define do |scr|
  factory :sale_category_row do
    association :sale
    association :category, :factory => :sale_category
    amount 1
  end
end
