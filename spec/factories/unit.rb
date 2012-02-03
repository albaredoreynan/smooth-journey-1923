FactoryGirl.define do
  factory :unit do
    sequence(:symbol) {|n| "unit#{n}"}
  end
end
