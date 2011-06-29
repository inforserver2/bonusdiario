#encoding: UTF-8
class User < ActiveRecord::Base
mount_uploader :avatar, AvatarUploader
validates_integrity_of :avatar
validates_processing_of :avatar


attr_accessor :close,:money,:comm,:mail
attr_accessor :plan, :qty
attr_accessor :person #{1:mass}
attr_accessor :pwd_changes, :new_password,:new_password_confirmation,:old_password


has_many :contracts, :dependent=>:destroy
has_many :cycles, :through => :contracts
has_many :bills, :through => :contracts
has_many :comms
has_many :payouts, :dependent=>:destroy
has_one :address, :dependent=>:destroy
has_one :bank_account, :dependent=>:destroy
belongs_to :gender

belongs_to :sponsor, :class_name=>"User", :foreign_key=>:sponsor_id, :counter_cache=>:sponsored_count
has_many :sponsored, :class_name=>"User", :foreign_key=>:sponsor_id

def self.matrix id,level=1
  users=case level
  when 1 then 
    where(:sponsor_id=>id).where("id != ?",id)
  when 2 then 
    where(:sponsor_id=>where(:sponsor_id=>id).where("id != ?",id))
  when 3 then 
    where(:sponsor_id=>where(:sponsor_id=>where(:sponsor_id=>id).where("id != ?",id)))
  when 4 then 
    where(:sponsor_id=>where(:sponsor_id=>where(:sponsor_id=>where(:sponsor_id=>id).where("id != ?",id))))
  when 5 then 
    where(:sponsor_id=>where(:sponsor_id=>where(:sponsor_id=>where(:sponsor_id=>where(:sponsor_id=>id).where("id != ?",id)))))
  else
    nil  
  end
end


validates_presence_of :sponsor_id
validates_presence_of :nick

validates_format_of :email1, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
validate :email2_filter

validates_length_of :password, :in=>5..25
validates_confirmation_of :password

validates_uniqueness_of :name
validates_length_of :name, :in=>3..25
validates_format_of :name, :with => /\A[a-zA-Z0-9]+\z/
validate :avatar_size_validation, :if => Proc.new { |user| user.avatar.present? }
validate :filter_password_changes, :ensure_names_valid



private
def ensure_names_valid
  if person==1
    num = qty
    while num > 0 
      name=[self.name,num].join
      errors.add(:name, "#{name} não aceito!") if User.where(:name=>name).present?
      num -= 1

    end
  end
end

  def gender_attribution
    if gender_id.present?
      validates_inclusion_of :gender_id, :in => [1,2]
    end
  end

  def avatar_size_validation
    errors.add(:avatar, "tamanho deve ser menor que 2 megabytes" ) if avatar.size > 2.megabytes
  end

  def ensure_email2_is_valid
      validates_format_of :email2, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  end

  def ensure_email2_differs_email1
    errors.add(:base,"email1 e email2 devem ser diferentes") if email1==email2
  end
  
  def email2_filter
    if email2.present?
      ensure_email2_is_valid
      ensure_email2_differs_email1
    end
  end

  def filter_password_changes
    if pwd_changes==true
      validates_length_of :new_password, :in=>5..25
      validates_confirmation_of :new_password
      if old_password!=password
        errors.add(:old_password, "inválida!")
      end
    end
  end


  def self.upline_qualified? user
    if (user.sponsored..where(:status=>1).count >= 3) || user.id==1
      user
    else
      User.upline_qualified? user.sponsor
    end
  end

  def self.cycle(user, cycle_type_id, status)
    cycle=user.cycles.where(:cycle_type_id=>cycle_type_id, :status=>status)
    if cycle.present?
      cycle.first
    else
      User.cycle(user.sponsor, cycle_type_id, status)
    end
  end



end

# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  fullname   :string(255)
#  nick       :string(255)
#  name       :string(255)
#  password   :string(255)
#  email1     :string(255)
#  email2     :string(255)
#  status     :integer(4)      default(0)
#  sponsor_id :integer(4)
#  created_at :datetime
#  updated_at :datetimeu

