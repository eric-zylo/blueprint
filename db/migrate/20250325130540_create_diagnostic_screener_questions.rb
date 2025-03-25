class CreateDiagnosticScreenerQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnostic_screener_questions do |t|
      t.references :diagnostic_screener, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
