class DropQuestionsForeignKeys < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :answers, :questions
    remove_foreign_key :domain_mappings, :questions
  end
end
