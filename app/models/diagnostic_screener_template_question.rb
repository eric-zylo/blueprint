class DiagnosticScreenerTemplateQuestion < ApplicationRecord
  belongs_to :diagnostic_screener_template
  belongs_to :question
end
