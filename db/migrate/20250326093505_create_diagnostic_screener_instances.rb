class CreateDiagnosticScreenerInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :diagnostic_screener_instances, id: :uuid do |t|
      t.string :name
      t.string :token, null: false

      t.timestamps
    end

    add_index :diagnostic_screener_instances, :token, unique: true
  end
end
