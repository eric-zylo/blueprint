class RecreateQuestionsForeignKeys < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :answers, :questions, column: :question_id, type: :uuid
    add_foreign_key :domain_mappings, :questions, column: :question_id, type: :uuid
  end
end
