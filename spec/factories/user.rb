FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'password'

    factory :admin_user do
      role 'admin'
    end

    factory :branch_user do
      role 'branch'
    end
  end
end
