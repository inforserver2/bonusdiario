class Payout < ActiveRecord::Base
  attr_accessor :mail
  belongs_to :user
  has_many :comms
end

# == Schema Information
#
# Table name: payouts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  value      :float
#  status     :integer(4)      default(0)
#  created_at :datetime
#  updated_at :datetime
#

