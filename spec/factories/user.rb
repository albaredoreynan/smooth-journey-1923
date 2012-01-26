FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "test#{n}"}
    sequence(:email) {|n| "test#{n}@example.com"}
    password 'password'

    factory :admin_user do
      email 'admin@example.com'
      after_create do |user|
        FactoryGirl.create(:role, name: 'admin', user: user)
      end
    end

    factory :client_user do
      email 'client@example.com'
      after_create do |user|
        company = FactoryGirl.create(:company)
        FactoryGirl.create(:role, name: 'client', company: company, user: user)
      end
    end

    factory :branch_user do
      email 'branch@example.com'
      after_create do |user|
        branch = FactoryGirl.create(:branch)
        FactoryGirl.create(:role, name: 'branch', branch: branch, user: user)
      end
    end
  end
end
