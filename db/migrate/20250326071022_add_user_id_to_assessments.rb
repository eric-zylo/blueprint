class AddUserIdToAssessments < ActiveRecord::Migration[8.0]
  def change
    add_reference :assessments, :user, type: :uuid, index: true, foreign_key: true
  end
end
