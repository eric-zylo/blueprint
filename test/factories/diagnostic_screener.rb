FactoryBot.define do
  factory :diagnostic_screener do
    name { Faker::Alphanumeric.alpha(number: 4).upcase }
    display_name { Faker::Alphanumeric.alpha(number: 3).upcase }
    full_name { "#{Faker::Company.name} Diagnostic Screener" }
    disorder { Faker::Lorem.words(number: 2).join(" ").titleize }
  end
end
