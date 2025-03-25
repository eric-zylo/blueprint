class DiagnosticScreener < ApplicationRecord
  has_many :diagnostic_screener_questions, dependent: :destroy
  has_many :questions, through: :diagnostic_screener_questions

  validates :name, :disorder, :display_name, :full_name, presence: true
end
