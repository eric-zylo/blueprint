require 'test_helper'

class PatientPolicyTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @other_user = create(:user)
    @patient = create(:patient, user: @user)
    @other_patient = create(:patient, user: @other_user)
  end

  test "should allow user to view their own patients" do
    assert_policy_action(:index?, @user, @patient, true)
  end

  test "should prevent user from viewing another user's patients" do
    assert_policy_action(:index?, @other_user, @patient, false)
  end

  test "should allow user to create a patient" do
    assert_policy_action(:create?, @user, Patient.new(user: @user), true)
  end

  test "should allow user to edit their own patient" do
    assert_policy_action(:edit?, @user, @patient, true)
  end

  test "should prevent user from editing another user's patient" do
    assert_policy_action(:edit?, @user, @other_patient, false)
  end

  test "should allow user to update their own patient" do
    assert_policy_action(:update?, @user, @patient, true)
  end

  test "should prevent user from updating another user's patient" do
    assert_policy_action(:update?, @user, @other_patient, false)
  end

  test "should allow user to destroy their own patient" do
    assert_policy_action(:destroy?, @user, @patient, true)
  end

  test "should prevent user from destroying another user's patient" do
    assert_policy_action(:destroy?, @user, @other_patient, false)
  end

  private

  def assert_policy_action(action, user, patient, expected)
    policy = PatientPolicy.new(user, patient)
    message = "Expected #{action} to be #{expected ? 'true' : 'false'} for user #{user.id} and patient #{patient.id}"
    
    assert_equal expected, policy.send(action), message
  end
end
