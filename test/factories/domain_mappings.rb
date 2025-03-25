FactoryBot.define do
  factory :domain_mapping do
    question
    domain { DomainMapping.domains.keys.sample }
  end
end
