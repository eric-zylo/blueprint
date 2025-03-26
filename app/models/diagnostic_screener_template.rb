class DiagnosticScreenerTemplate < ApplicationRecord
  has_many :questions, as: :questionable, dependent: :destroy
  has_many :diagnostic_screener_instances
  
  validates :name, :disorder, :display_name, :full_name, presence: true
end
