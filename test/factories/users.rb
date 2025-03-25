FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "Valid!123" }
    password_confirmation { "Valid!123" }
    first_name { "John" }
    last_name { "Doe" }
    confirmed_at { Time.current }
  end
end
