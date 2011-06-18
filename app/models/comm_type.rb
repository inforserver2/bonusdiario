class CommType < ActiveRecord::Base
  has_many :comms
end

# == Schema Information
#
# Table name: comm_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  porcentage :float
#  created_at :datetime
#  updated_at :datetime
#

