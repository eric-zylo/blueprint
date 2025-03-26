FactoryBot.define do
  factory :diagnostic_screener_instance do
    user
    patient
    diagnostic_screener_template

    trait :with_results do
      after(:create) do |diagnostic_screener_instance|
        create_list(:diagnostic_screener_result, 3, diagnostic_screener_instance: diagnostic_screener_instance)
      end
    end

    trait :completed do
      completed_at { Time.now }
    end

    trait :with_questions do
      after(:create) do |diagnostic_screener_instance|
        diagnostic_screener_instance.diagnostic_screener_template.questions.each do |question|
          create(:diagnostic_screener_result, diagnostic_screener_instance: diagnostic_screener_instance, question: question)
        end
      end
    end
  end
end
