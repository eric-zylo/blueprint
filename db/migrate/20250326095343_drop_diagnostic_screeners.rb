class DropDiagnosticScreeners < ActiveRecord::Migration[8.0]
  def change
    drop_table :diagnostic_screeners
  end
end
