class AddCompletedAtToDiagnosticScreenerInstances < ActiveRecord::Migration[8.0]
  def change
    add_column :diagnostic_screener_instances, :completed_at, :datetime
  end
end
