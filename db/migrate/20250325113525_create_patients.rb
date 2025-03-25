class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    enable_extension 'pgcrypto'

    create_table :patients, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
