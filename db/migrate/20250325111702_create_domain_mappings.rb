class CreateDomainMappings < ActiveRecord::Migration[8.0]
  def change
    create_table :domain_mappings do |t|
      t.integer :domain
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
