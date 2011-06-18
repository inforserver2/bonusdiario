require 'test_helper'

class BillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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

