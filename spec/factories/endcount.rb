FactoryGirl.define do
  factory :endcount do
    begin_date 5.days.ago
    end_date Time.now
    save_as_draft 1
  end
end
