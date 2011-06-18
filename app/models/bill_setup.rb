class BillSetup < ActiveRecord::Base
  belongs_to :bill
end

# == Schema Information
#
# Table name: bill_setups
#
#  id         :integer(4)      not null, primary key
#  close      :boolean(1)
#  money      :boolean(1)
#  comm       :boolean(1)
#  mail       :boolean(1)
#  bill_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

