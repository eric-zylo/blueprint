class AddTokenToDiagnosticScreeners < ActiveRecord::Migration[8.0]
  def change
    add_column :diagnostic_screeners, :token, :string
    add_index :diagnostic_screeners, :token, unique: true
  end
end
