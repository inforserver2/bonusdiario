class Comm < ActiveRecord::Base
  attr_accessor :mail
  belongs_to :bill
  belongs_to :user
  belongs_to :payout
  belongs_to :comm_type
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

