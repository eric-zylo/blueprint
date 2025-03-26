class CreateDiagnosticScreenerTemplateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnostic_screener_template_questions, id: :uuid do |t|
      t.references :diagnostic_screener_template, null: false, foreign_key: { to_table: :diagnostic_screener_templates, on_delete: :cascade }, type: :uuid
      t.references :question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
