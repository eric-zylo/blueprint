class DropDiagnosticScreenerQuestions < ActiveRecord::Migration[8.0]
  def change
    drop_table :diagnostic_screener_questions
  end
end
