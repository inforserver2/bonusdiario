class Support < ActiveRecord::Base
  validates_presence_of :subject,:message,:user_id
end

# == Schema Information
#
# Table name: supports
#
#  id         :integer(4)      not null, primary key
#  subject    :string(255)
#  message    :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

