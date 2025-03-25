require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = build(:question)
  end

  test "question should be valid" do
    assert @question.valid?
  end

  test "text should be present" do
    @question.title = nil
    assert_not @question.valid?
  end
end
