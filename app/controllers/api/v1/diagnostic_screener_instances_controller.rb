class Api::V1::DiagnosticScreenerInstancesController < ApplicationController
  def show
    @screener = DiagnosticScreenerInstance.find_by(token: params[:token])

    if @screener
      if @screener.completed_at.nil?
        render json: @screener.to_diagnostic_screener_json
      else
        render json: { error: 'This screener has already been completed.' }, status: :ok
      end
    else
      render json: { error: 'Diagnostic Screener not found' }, status: :not_found
    end
  end

  def score
    answers = params[:answers]
    token = params[:token]
    diagnostic_screener_instance = DiagnosticScreenerInstance.find_by(token: token)

    if diagnostic_screener_instance.nil?
      render json: { error: 'Diagnostic screener instance not found' }, status: :not_found
      return
    end

    domains = {}

    answers.each do |answer|
      question = Question.find_by(id: answer[:question_id])
      next if question.nil?

      domain_mapping = DomainMapping.find_by(question_id: question.id)
      next if domain_mapping.nil?

      domain = domain_mapping.domain

      domains[domain] ||= 0
      domains[domain] += answer[:value].to_i
    end

    assessments = []
    assessments << "PHQ-9" if (domains[:depression] || 0) >= 2 || (domains[:anxiety] || 0) >= 2
    assessments << "ASRM" if (domains[:mania] || 0) >= 2
    assessments << "ASSIST" if (domains[:substance_use] || 0) >= 1

    results = []

    domains.each do |domain, score|
      assessment_type = case domain
                        when "depression", "anxiety" then "PHQ-9"
                        when "mania" then "ASRM"
                        when "substance_use" then "ASSIST"
                        else "Unknown"
                        end

      if (domain == "depression" && score >= 2) ||
         (domain == "mania" && score >= 2) ||
         (domain == "anxiety" && score >= 2) ||
         (domain == "substance_use" && score >= 1)
        results << {
          domain: domain,
          score: score,
          assessment_type: assessment_type
        }
      end
    end

    diagnostic_screener_instance.update(completed_at: Time.current)

    render json: { results: results, assessments: assessments }, status: :ok
  end
end
