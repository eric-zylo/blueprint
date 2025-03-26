require 'test_helper'

class AssessmentPolicyTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @other_user = create(:user)
    @assessment = create(:assessment, user: @user)
    @other_assessment = create(:assessment, user: @other_user)
  end

  test "should allow user to view their own assessments" do
    assert_policy_action(:index?, @user, @assessment, true)
  end

  test "should prevent user from viewing another user's assessments" do
    assert_policy_action(:index?, @other_user, @assessment, false)
  end

  test "should allow user to create an assessment" do
    assert_policy_action(:create?, @user, Assessment.new(user: @user), true)
  end

  test "should allow user to edit their own assessment" do
    assert_policy_action(:edit?, @user, @assessment, true)
  end

  test "should prevent user from editing another user's assessment" do
    assert_policy_action(:edit?, @user, @other_assessment, false)
  end

  test "should allow user to update their own assessment" do
    assert_policy_action(:update?, @user, @assessment, true)
  end

  test "should prevent user from updating another user's assessment" do
    assert_policy_action(:update?, @user, @other_assessment, false)
  end

  test "should allow user to destroy their own assessment" do
    assert_policy_action(:destroy?, @user, @assessment, true)
  end

  test "should prevent user from destroying another user's assessment" do
    assert_policy_action(:destroy?, @user, @other_assessment, false)
  end

  private

  def assert_policy_action(action, user, assessment, expected)
    policy = AssessmentPolicy.new(user, assessment)
    message = "Expected #{action} to be #{expected ? 'true' : 'false'} for user #{user.id} and assessment #{assessment.id}"
    
    assert_equal expected, policy.send(action), message
  end
end
