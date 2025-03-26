class CreateDiagnosticScreenerTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnostic_screener_templates, id: :uuid do |t|
      t.string :name
      t.string :disorder
      t.string :display_name
      t.string :full_name

      t.timestamps
    end
  end
end
