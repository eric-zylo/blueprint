FactoryBot.define do
  factory :diagnostic_screener_question do
    diagnostic_screener
    question
    position { Faker::Number.between(from: 1, to: 10) }
  end
end
