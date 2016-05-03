# User class
FactoryGirl.define do
  sequence(:email) { |n| "example#{n}@example.com" }
  sequence(:name) { |n| "test name #{n}" }
  sequence(:issue_subject) { |n| "Issue №#{n}" }

  factory :staff do
    username  { FactoryGirl.generate(:name) }
    email     { FactoryGirl.generate(:email) }
    password  'B@d_pa$sW0rd'
    admin     false

    trait :admin do
      admin true
    end
  end

  factory :issue do
    name        { FactoryGirl.generate(:name) }
    email       { FactoryGirl.generate(:email) }
    subject     { FactoryGirl.generate(:issue_subject) }
    body        'some testing'
    department  'IT'
  end
end
