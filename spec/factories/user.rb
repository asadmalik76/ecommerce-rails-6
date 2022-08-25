require 'faker'
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name  }
    last_name  { Faker::Name.name  }
    email { Faker::Internet.email }
    password { 'test1234' }

    trait :seller do
      after(:create) { |user| user.add_role(:seller) }
    end

    trait :buyer do
      after(:create) { |user| user.add_role(:buyer) }
    end
  end
end
