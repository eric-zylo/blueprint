FactoryBot.define do
  factory :assessment do
    patient
    user

    trait :with_answers do
      after(:create) do |assessment|
        create_list(:answer, 3, assessment: assessment)
      end
    end
  end
end
