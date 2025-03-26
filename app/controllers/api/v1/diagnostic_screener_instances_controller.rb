class Api::V1::DiagnosticScreenerInstancesController < ApplicationController
  def show
    screener_instance = DiagnosticScreenerInstance.find_by!(token: params[:token])

    render json: screener_instance.diagnostic_screener_template, include: [:questions, :domain_mappings]
  end

  def score
    answers = params[:answers]
    domains = { depression: 0, mania: 0, anxiety: 0, substance_use: 0 }

    answers.each do |answer|
      question = Question.find_by(id: answer[:question_id])
      domain = DomainMapping.find_by(question_id: question.id).domain
      domains[domain] += answer[:value]
    end

    assessments = []
    assessments << "PHQ-9" if domains[:depression] >= 2 || domains[:anxiety] >= 2
    assessments << "ASRM" if domains[:mania] >= 2
    assessments << "ASSIST" if domains[:substance_use] >= 1

    screener_result = DiagnosticScreenerResult.create!(
      patient_id: params[:patient_id],
      diagnostic_screener_instance_id: params[:diagnostic_screener_instance_id],
      answers: answers,
      assessments: assessments
    )

    assessments.each do |assessment_name|
      Assessment.create!(name: assessment_name, patient_id: params[:patient_id], user_id: params[:user_id])
    end

    render json: { results: assessments }
  end

  def create
    screener_template = DiagnosticScreenerTemplate.find(params[:diagnostic_screener_template_id])

    screener_instance = DiagnosticScreenerInstance.create!(
      patient_id: params[:patient_id],
      user_id: params[:user_id],
      diagnostic_screener_template_id: screener_template.id
    )

    render json: { token: screener_instance.token, screener_instance_id: screener_instance.id }
  end
end
