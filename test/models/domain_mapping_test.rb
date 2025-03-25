require "test_helper"

class DomainMappingTest < ActiveSupport::TestCase
  def setup
    @question = create(:question)
    @domain_mapping = build(:domain_mapping, question: @question)
  end

  test "domain_mapping should be valid" do
    assert @domain_mapping.valid?
  end

  test "question should be present" do
    @domain_mapping.question = nil
    assert_not @domain_mapping.valid?
  end

  test "domain should be present" do
    @domain_mapping.domain = nil
    assert_not @domain_mapping.valid?
  end

  test "domain should be a valid domain" do
    assert_raises ArgumentError do
      @domain_mapping.domain = "invalid_domain"
    end
  end
end
