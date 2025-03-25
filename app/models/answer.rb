class Answer < ApplicationRecord
  belongs_to :assessment
  belongs_to :question
  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
