class Question < ApplicationRecord
  belongs_to :questionable, polymorphic: true
  has_many :answers
  has_one :domain_mapping
  has_many :diagnostic_screener_template_questions
  has_many :diagnostic_screener_templates, through: :diagnostic_screener_template_questions

  validates :title, presence: true
end
