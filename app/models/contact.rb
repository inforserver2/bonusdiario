class Contact < ActiveRecord::Base
  
  validates_presence_of :name,:email,:subject,:message,:sponsor_name
  validate :ensure_email_is_valid
  
  def ensure_email_is_valid
    if email.present?
      validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    end
  end

end

# == Schema Information
#
# Table name: contacts
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  email        :string(255)
#  subject      :string(255)
#  message      :text
#  sponsor_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

