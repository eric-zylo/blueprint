class DiagnosticScreenerInstance < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  has_many :diagnostic_screener_results
  has_many :questions, through: :diagnostic_screener_template

  belongs_to :diagnostic_screener_template

  before_validation :generate_token, on: :create
  after_create :send_screener_assigned_email

  validates :token, presence: true, uniqueness: true

  def to_diagnostic_screener_json
    {
      id: self.id,
      name: self.diagnostic_screener_template.name,
      disorder: self.diagnostic_screener_template.disorder,
      content: {
        sections: [
          {
            type: 'standard',
            title: 'During the past TWO (2) WEEKS, how much (or how often) have you been bothered by the following problems?',
            answers: [
              { title: 'Not at all', value: 0 },
              { title: 'Rare, less than a day or two', value: 1 },
              { title: 'Several days', value: 2 },
              { title: 'More than half the days', value: 3 },
              { title: 'Nearly every day', value: 4 }
            ],
            questions: self.diagnostic_screener_template.questions.map do |question|
              { question_id: question.id, title: question.title }
            end
          }
        ],
        display_name: self.diagnostic_screener_template.display_name
      },
      full_name: self.diagnostic_screener_template.full_name
    }.to_json
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def send_screener_assigned_email
    DiagnosticScreenerInstanceMailer.screener_assigned(self).deliver_now
  end
end
