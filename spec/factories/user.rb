FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'password'

    factory :admin_user do
      email 'admin@example.com'
      after_create do |user|
        FactoryGirl.create(:role, :name => 'admin', :user => user)
      end
    end

    factory :branch_user do
      email 'branch@example.com'
      after_create do |user|
        branch = FactoryGirl.create(:branch)
        FactoryGirl.create(:role, :name => 'branch', :branch => branch, :user => user)
      end
    end
  end
end
