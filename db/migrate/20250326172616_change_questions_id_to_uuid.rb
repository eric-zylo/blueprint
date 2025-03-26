class ChangeQuestionsIdToUuid < ActiveRecord::Migration[8.0]
  def change
    remove_column :questions, :id
    add_column :questions, :id, :uuid, primary_key: true, default: 'gen_random_uuid()', null: false
  end
end
