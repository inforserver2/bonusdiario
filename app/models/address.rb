class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  validates_presence_of :user_id, :country_id
  validates_presence_of :state_name, :city_name, :on=>:update
end
