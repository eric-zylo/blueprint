class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.references :assessment, null: false, foreign_key: true, index: true
      t.references :question, null: false, foreign_key: true, index: true
      t.integer :value

      t.timestamps
    end
  end
end
