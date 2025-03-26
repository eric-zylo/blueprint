class DiagnosticScreenerResult < ApplicationRecord
  belongs_to :diagnostic_screener_instance
  belongs_to :question
  has_many :assessments

  validates :score, presence: true
end
