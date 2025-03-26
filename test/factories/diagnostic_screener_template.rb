FactoryBot.define do
  factory :diagnostic_screener_template do
    name { Faker::Lorem.word }
    disorder { Faker::Lorem.word }
    display_name { Faker::Lorem.sentence }
    full_name { Faker::Lorem.sentence }

    trait :with_questions do
      after(:create) do |diagnostic_screener_template|
        create_list(:question, 3, questionable: diagnostic_screener_template)
      end
    end
  end
end
