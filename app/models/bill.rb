class Bill < ActiveRecord::Base
  attr_accessor :close,:money,:comm,:mail
  attr_accessor :from_cycle_id
  belongs_to :contract
  has_one :bill_setup, :dependent=>:destroy
  has_many :comms, :dependent=>:destroy
end

# == Schema Information
#
# Table name: bills
#
#  id          :integer(4)      not null, primary key
#  contract_id :integer(4)
#  value       :float
#  status      :integer(4)      default(0)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

