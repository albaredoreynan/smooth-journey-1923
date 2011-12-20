FactoryGirl.define do
  factory :conversion do
    association :bigger_unit, :factory => :unit, :name => 'in'
    association :smaller_unit, :factory => :unit, :name => 'cm'
    conversion_factor 2.54
  end
end
