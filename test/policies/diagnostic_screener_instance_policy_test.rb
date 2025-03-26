require 'test_helper'

class DiagnosticScreenerInstancePolicyTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @patient = create(:patient, user: @user)
    @diagnostic_screener_instance = create(:diagnostic_screener_instance, user: @user, patient: @patient)
  end

  test "any logged in user can create diagnostic screener instance" do
    assert DiagnosticScreenerInstancePolicy.new(@user, DiagnosticScreenerInstance.new).create?
  end

  test "any user can show diagnostic screener instance" do
    assert DiagnosticScreenerInstancePolicy.new(@user, @diagnostic_screener_instance).show?
    assert DiagnosticScreenerInstancePolicy.new(nil, @diagnostic_screener_instance).show?
  end
end
