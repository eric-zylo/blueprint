class ChangeDomainMappingsQuestionIdToUuid < ActiveRecord::Migration[8.0]
  def change
    change_column :domain_mappings, :question_id, :uuid, using: 'question_id::text::uuid'
  end
end
