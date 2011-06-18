class Cycle < ActiveRecord::Base

  attr_accessor :mail
  
  belongs_to :contract
  belongs_to :cycle

  belongs_to :from, :class_name=>"Cycle", :foreign_key=>:from_cycle_id
  has_many :childrens, :class_name=>"Cycle", :foreign_key=>:from_cycle_id

  belongs_to :sponsor, :class_name=>"Cycle", :foreign_key=>:sponsor_id, :counter_cache=>:sponsored_count
  has_many :sponsored, :class_name=>"Cycle", :foreign_key=>:sponsor_id

end
