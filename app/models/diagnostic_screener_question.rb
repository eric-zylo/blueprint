class DiagnosticScreenerQuestion < ApplicationRecord
  belongs_to :diagnostic_screener
  belongs_to :question

  validates :position, presence: true
end
