require "test_helper"

class AssessmentTest < ActiveSupport::TestCase
  def setup
    @patient = create(:patient)
    @assessment = build(:assessment, patient: @patient)
  end

  test "assessment should be valid" do
    assert @assessment.valid?
  end

  test "patient should be present" do
    @assessment.patient = nil
    assert_not @assessment.valid?
  end

  test "token should be unique" do
    existing_assessment = create(:assessment)
    @assessment.token = existing_assessment.token
    assert_not @assessment.valid?
  end

  test "token should be generated on create" do
    new_assessment = create(:assessment, patient: @patient)
    assert_not_nil new_assessment.token
  end
end
