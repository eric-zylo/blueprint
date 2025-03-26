require "test_helper"

class DiagnosticScreenerInstanceMailerTest < ActionMailer::TestCase
  test "screener_assigned" do
    mail = DiagnosticScreenerInstanceMailer.screener_assigned
    assert_equal "Screener assigned", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
