class DiagnosticScreenerTemplate < ApplicationRecord
  has_many :diagnostic_screener_template_questions
  has_many :questions, through: :diagnostic_screener_template_questions
  has_many :diagnostic_screener_instances
  
  validates :name, :disorder, :display_name, :full_name, presence: true
end
