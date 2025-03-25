FactoryBot.define do
  factory :patient do
    user
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.unique.email }
  end
end