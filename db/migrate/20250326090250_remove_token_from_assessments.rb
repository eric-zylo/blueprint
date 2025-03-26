class RemoveTokenFromAssessments < ActiveRecord::Migration[8.0]
  def change
    remove_column :assessments, :token, :string
  end
end
