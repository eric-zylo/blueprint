require "test_helper"

class PatientTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @patient = build(:patient, user: @user)
  end

  test "patient should be valid" do
    assert @patient.valid?
  end

  test "user should be present" do
    @patient.user = nil
    assert_not @patient.valid?
  end

  test "first_name should be present" do
    @patient.first_name = nil
    assert_not @patient.valid?
  end

  test "last_name should be present" do
    @patient.last_name = nil
    assert_not @patient.valid?
  end

  test "email should be present" do
    @patient.email = nil
    assert_not @patient.valid?
  end
end
