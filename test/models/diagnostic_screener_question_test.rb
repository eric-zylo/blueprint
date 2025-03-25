require "test_helper"

class DiagnosticScreenerQuestionTest < ActiveSupport::TestCase
  def setup
    @screener_question = build(:diagnostic_screener_question)
  end

  test "is valid with valid attributes" do
    assert @screener_question.valid?
  end

  test "is invalid without a diagnostic_screener" do
    @screener_question.diagnostic_screener = nil
    assert_not @screener_question.valid?
  end

  test "is invalid without a question" do
    @screener_question.question = nil
    assert_not @screener_question.valid?
  end

  test "is invalid without a position" do
    @screener_question.position = nil
    assert_not @screener_question.valid?
  end
end
