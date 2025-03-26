class AddRelationshipsToDiagnosticInstances < ActiveRecord::Migration[8.0]
  def change
    add_reference :diagnostic_screener_instances, :user, type: :uuid, index: true, foreign_key: true
    add_reference :diagnostic_screener_instances, :patient, type: :uuid, index: true, foreign_key: true
  end
end
