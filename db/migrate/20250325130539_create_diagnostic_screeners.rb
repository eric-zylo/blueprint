class CreateDiagnosticScreeners < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnostic_screeners do |t|
      t.string :name
      t.string :disorder
      t.string :display_name
      t.string :full_name

      t.timestamps
    end
  end
end
