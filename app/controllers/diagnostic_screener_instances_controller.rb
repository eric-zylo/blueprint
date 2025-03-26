class DiagnosticScreenerInstancesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_patient, only: [:create]

  def show
    @diagnostic_screener_instance = DiagnosticScreenerInstance.find_by(token: params[:token])

    if @diagnostic_screener_instance.present?
      if user_signed_in?
        redirect_to authenticated_root_path
      else
        redirect_to unauthenticated_root_path
      end
    else
      # Render the screener for the patient to fill out
    end
  end

  def create
    template = DiagnosticScreenerTemplate.find(params[:diagnostic_screener_template_id])

    @diagnostic_screener_instance = DiagnosticScreenerInstance.new(
      name: template.name,
      patient: @patient,
      user: current_user,
      diagnostic_screener_template: template
    )

    if @diagnostic_screener_instance.save
      redirect_to user_patient_path(current_user, @patient), notice: 'Diagnostic screener has been assigned successfully.'
    else
      redirect_to user_patient_path(params[:user_id], params[:patient_id]), alert: 'There was an error assigning the diagnostic screener.'
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def diagnostic_screener_instance_params
    params.permit(:diagnostic_screener_template_id, :token)
  end
end
