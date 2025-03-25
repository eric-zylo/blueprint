require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  def setup
    @assessment = create(:assessment)
    @question = create(:question)
    @answer = build(:answer, assessment: @assessment, question: @question)
  end

  test "answer should be valid" do
    assert @answer.valid?
  end

  test "value should be present" do
    @answer.value = nil
    assert_not @answer.valid?
  end

  test "value should be an integer" do
    @answer.value = 3.5
    assert_not @answer.valid?
  end

  test "value should be within range 0-4" do
    @answer.value = -1
    assert_not @answer.valid?

    @answer.value = 5
    assert_not @answer.valid?
  end

  test "assessment should be present" do
    @answer.assessment = nil
    assert_not @answer.valid?
  end

  test "question should be present" do
    @answer.question = nil
    assert_not @answer.valid?
  end
end
