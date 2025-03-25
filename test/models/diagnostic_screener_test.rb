require "test_helper"

class DiagnosticScreenerTest < ActiveSupport::TestCase
  def setup
    @screener = build(:diagnostic_screener)
  end

  test "is valid with valid attributes" do
    assert @screener.valid?
  end

  test "is invalid without a name" do
    @screener.name = nil
    assert_not @screener.valid?
  end

  test "is invalid without a display_name" do
    @screener.display_name = nil
    assert_not @screener.valid?
  end

  test "is invalid without a full_name" do
    @screener.full_name = nil
    assert_not @screener.valid?
  end
end
