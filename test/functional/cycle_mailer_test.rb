require 'test_helper'

class CycleMailerTest < ActionMailer::TestCase
  test "open" do
    mail = CycleMailer.open
    assert_equal "Open", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "close" do
    mail = CycleMailer.close
    assert_equal "Close", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
