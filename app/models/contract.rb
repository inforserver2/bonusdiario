class Contract < ActiveRecord::Base

  attr_accessor :close,:money,:comm,:mail
  attr_accessor :from_cycle_id
 
  belongs_to :service
  belongs_to :user
  has_many :bills, :dependent=>:destroy
  has_one :cycle, :dependent=>:destroy

end

# == Schema Information
#
# Table name: contracts
#
#  id         :integer(4)      not null, primary key
#  service_id :integer(4)
#  user_id    :integer(4)
#  status     :integer(4)      default(0)
#  created_at :datetime
#  updated_at :datetime
#

