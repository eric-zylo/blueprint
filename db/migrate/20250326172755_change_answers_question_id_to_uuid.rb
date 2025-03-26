class ChangeAnswersQuestionIdToUuid < ActiveRecord::Migration[8.0]
  def change
    change_column :answers, :question_id, :uuid, using: 'question_id::text::uuid'
  end
end
