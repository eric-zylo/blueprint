require 'test_helper'

class Api::V1::DiagnosticScreenerInstancesControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  def setup
    @diagnostic_screener_instance = create(:diagnostic_screener_instance)
    @token = @diagnostic_screener_instance.token
    @patient = create(:patient)
    @user = create(:user)

    # Generate 10 questions with unique IDs
    @questions = create_list(:question, 10)

    # Use the generated question IDs in the answers payload
    @answers = @questions.map.with_index do |question, index|
      { "question_id": question.id, "value": index % 3 + 1 } # Values 1, 2, or 3
    end

    # Create domain mappings for the generated questions
    @answers.each do |answer|
      create(:domain_mapping, question_id: answer[:question_id], domain: case answer[:question_id]
                                                                            when @questions[0].id, @questions[1].id then "depression"
                                                                            when @questions[2].id, @questions[3].id then "mania"
                                                                            when @questions[4].id, @questions[5].id, @questions[6].id then "anxiety"
                                                                            when @questions[7].id, @questions[8].id, @questions[9].id then "substance_use"
                                                                            end)
    end

    @diagnostic_screener_instance.update(patient_id: @patient.id, user_id: @user.id)
  end

  test "scores the questionnaire and creates assessments" do
    post "/api/v1/diagnostic_screener_instances/score/#{@token}", params: { answers: @answers }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_includes json_response['results'], 'PHQ-9'
    assert_includes json_response['results'], 'ASRM'
    assert_includes json_response['results'], 'ASSIST'
    assert_includes json_response['results'], 'anxiety'

    assert_equal 1, DiagnosticScreenerResult.count
    assert_equal 4, Assessment.count

    @diagnostic_screener_instance.reload
    assert @diagnostic_screener_instance.completed_at.present?
  end

  test "handles missing question or domain mappings" do
    question_id_to_delete = @answers.first[:question_id]
  
    DomainMapping.where(question_id: question_id_to_delete).destroy_all
    Question.find_by(id: question_id_to_delete).destroy
  
    post "/api/v1/diagnostic_screener_instances/score/#{@token}", params: { answers: @answers }
    assert_response :success
  
    json_response = JSON.parse(response.body)
    assert_includes json_response['results'], 'PHQ-9'
    assert_includes json_response['results'], 'ASRM'
    assert_includes json_response['results'], 'ASSIST'
    assert_includes json_response['results'], 'anxiety'
  
    assert_equal 1, DiagnosticScreenerResult.count
    assert_equal 4, Assessment.count
  
    @diagnostic_screener_instance.reload
    assert @diagnostic_screener_instance.completed_at.present?
  end

  test "handles diagnostic_screener_instance not found" do
    post "/api/v1/diagnostic_screener_instances/score/invalid_token", params: { answers: @answers }
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal 'Diagnostic screener instance not found', json_response['error']
  end
end