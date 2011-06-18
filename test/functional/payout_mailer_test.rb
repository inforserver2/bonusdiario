require 'test_helper'

class PayoutMailerTest < ActionMailer::TestCase
  test "payout_new" do
    mail = PayoutMailer.payout_new
    assert_equal "Payout new", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "payout_sent" do
    mail = PayoutMailer.payout_sent
    assert_equal "Payout sent", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
