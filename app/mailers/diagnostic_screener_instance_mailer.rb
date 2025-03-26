class DiagnosticScreenerInstanceMailer < ApplicationMailer
  def screener_assigned(diagnostic_screener_instance)
    @diagnostic_screener_instance = diagnostic_screener_instance
    @patient = diagnostic_screener_instance.patient
    @user = diagnostic_screener_instance.patient.user
    @diagnostic_screener_template = diagnostic_screener_instance.diagnostic_screener_template
    @screener_url = diagnostic_screener_url(diagnostic_screener_instance.token)

    mail(to: @patient.email, subject: 'New Diagnostic Screener Assigned')
  end
end
