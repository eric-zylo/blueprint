questions_with_domains = [
  { title: "Little interest or pleasure in doing things?", domain: :depression },
  { title: "Feeling down, depressed, or hopeless?", domain: :depression },
  { title: "Sleeping less than usual, but still have a lot of energy?", domain: :mania },
  { title: "Starting lots more projects than usual or doing more risky things than usual?", domain: :mania },
  { title: "Feeling nervous, anxious, frightened, worried, or on edge?", domain: :anxiety },
  { title: "Feeling panic or being frightened?", domain: :anxiety },
  { title: "Avoiding situations that make you feel anxious?", domain: :anxiety },
  { title: "Drinking at least 4 drinks of any kind of alcohol in a single day?", domain: :substance_use }
]

ActiveRecord::Base.transaction do
  screener_template = DiagnosticScreenerTemplate.create!(
    name: "BPDS",
    disorder: "Cross-Cutting",
    display_name: "BDS",
    full_name: "Blueprint Diagnostic Screener"
  )

  questions_with_domains.each_with_index do |entry, index|
    question = Question.create!(title: entry[:title], questionable: screener_template)

    DomainMapping.create!(question: question, domain: entry[:domain])

    screener_template.questions << question
  end
end
