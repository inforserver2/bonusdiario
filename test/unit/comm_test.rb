require 'test_helper'

class CommTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: comms
#
#  id           :integer(4)      not null, primary key
#  bill_id      :integer(4)
#  value        :float
#  status       :integer(4)      default(0)
#  comm_type_id :integer(4)
#  user_id      :integer(4)
#  payout_id    :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

