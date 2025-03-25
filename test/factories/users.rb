FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "Valid!123" }
    password_confirmation { "Valid!123" }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    confirmed_at { Time.current }
  end
end
