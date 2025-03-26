class DiagnosticScreenerInstance < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  has_many :diagnostic_screener_results
  has_many :questions, through: :diagnostic_screener_template

  belongs_to :diagnostic_screener_template

  before_validation :generate_token, on: :create
  after_create :send_screener_assigned_email

  validates :token, presence: true, uniqueness: true

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def send_screener_assigned_email
    DiagnosticScreenerInstanceMailer.screener_assigned(self).deliver_now
  end
end
