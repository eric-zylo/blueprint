FactoryBot.define do
  factory :question do
    title { Faker::Lorem.question }

    trait :with_domain_mapping do
      after(:create) do |question|
        create(:domain_mapping, question: question)
      end
    end
  end
end
