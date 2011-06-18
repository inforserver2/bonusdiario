require 'test_helper'

class BillMailerTest < ActionMailer::TestCase
  test "billing" do
    mail = BillMailer.billing
    assert_equal "Billing", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "receipt" do
    mail = BillMailer.receipt
    assert_equal "Receipt", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
