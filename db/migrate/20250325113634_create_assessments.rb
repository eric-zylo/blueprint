class CreateAssessments < ActiveRecord::Migration[8.0]
  def change
    create_table :assessments do |t|
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.date :completed_at
      t.string :token

      t.timestamps
    end
  end
end
