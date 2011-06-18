#encoding: UTF-8
class Session < ActiveRecord::Base
  
  attr_accessor :profile, :token
  validates_presence_of :name, :if=>"profile==1"
  validates_presence_of :password, :if=>"profile==1"
  validates_presence_of :email, :if=>"profile==2"
  validate :auth_name, :filter_email,:auth_email
  
  def auth_name
    if profile==1 && name.present? && password.present?
     if user=User.select([:id,:token]).where(:name=>name,:password=>password).first
       self.token=user.token
     else
       errors.add(:base,"Login ou senha inválida. Tente novamente!")
       false
     end
    end
  end

  def filter_email
    if profile==2 && email.present? 
      validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    end
  end           


  def auth_email
    if profile==2 && email.present? && errors[:email].empty?
     users=User.select([:id,:name,:password,:nick,:email1,:email2]).where(["email1=? OR email2=?",email,email])
     if users.any?
       users
     else
       errors.add(:base,"#{email} não cadastrado aqui.")
       false
     end
    end
  end

end
