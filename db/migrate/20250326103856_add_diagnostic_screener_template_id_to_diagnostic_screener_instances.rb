class AddDiagnosticScreenerTemplateIdToDiagnosticScreenerInstances < ActiveRecord::Migration[8.0]
  def change
    add_reference :diagnostic_screener_instances, :diagnostic_screener_template, type: :uuid, foreign_key: true
  end
end
