FactoryBot.define do
  factory :answer do
    assessment
    question
    value { Faker::Number.between(from: 0, to: 4) }
  end
end
