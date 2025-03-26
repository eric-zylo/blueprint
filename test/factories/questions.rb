FactoryBot.define do
  factory :question do
    title { Faker::Lorem.question }
    questionable { association(:diagnostic_screener_template) }

    trait :with_domain_mapping do
      after(:create) do |question|
        create(:domain_mapping, question: question)
      end
    end
  end
end
