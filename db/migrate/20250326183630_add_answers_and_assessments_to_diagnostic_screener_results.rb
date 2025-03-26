class AddAnswersAndAssessmentsToDiagnosticScreenerResults < ActiveRecord::Migration[8.0]
  def change
    add_column :diagnostic_screener_results, :answers, :jsonb
    add_column :diagnostic_screener_results, :assessments, :jsonb
  end
end
