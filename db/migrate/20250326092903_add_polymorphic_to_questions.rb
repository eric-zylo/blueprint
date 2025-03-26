class AddPolymorphicToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_reference :questions, :questionable, polymorphic: true, null: false
  end
end
