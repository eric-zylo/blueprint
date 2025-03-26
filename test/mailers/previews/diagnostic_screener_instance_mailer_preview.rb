# Preview all emails at http://localhost:3000/rails/mailers/diagnostic_screener_instance_mailer
class DiagnosticScreenerInstanceMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/diagnostic_screener_instance_mailer/screener_assigned
  def screener_assigned
    DiagnosticScreenerInstanceMailer.screener_assigned
  end
end
