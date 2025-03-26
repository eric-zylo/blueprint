class CreateDiagnosticScreenerResults < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnostic_screener_results, id: :uuid do |t|
      t.references :diagnostic_screener_instance, null: false, foreign_key: true, type: :uuid
      t.integer :score, null: false

      t.timestamps
    end
  end
end
