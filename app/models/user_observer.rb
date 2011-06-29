class UserObserver < ActiveRecord::Observer

  def after_create(user)
    

    #service1=Service.select([:id,:price]).find(user.plan || 1)
    service1=Service.select([:id,:price]).find(1)
    user.contracts.create(:service_id=>service1.id,:close=>user.close, :money=>user.money, :comm=>user.comm, :mail=>user.mail)
   # if user.id==1 
   #   service2=Service.select([:id,:price]).find(2)
   #   service3=Service.select([:id,:price]).find(3)
   #   service4=Service.select([:id,:price]).find(4)
   #   service5=Service.select([:id,:price]).find(5)
   #   user.contracts.create(:service_id=>service2.id,:close=>user.close, :money=>user.money, :comm=>user.comm, :mail=>user.mail)
   #   user.contracts.create(:service_id=>service3.id,:close=>user.close, :money=>user.money, :comm=>user.comm, :mail=>user.mail)
   #   user.contracts.create(:service_id=>service4.id,:close=>user.close, :money=>user.money, :comm=>user.comm, :mail=>user.mail)
   #   user.contracts.create(:service_id=>service5.id,:close=>user.close, :money=>user.money, :comm=>user.comm, :mail=>user.mail)
   # end

    if user.mail==true
      UserMailer.delay.welcome(user)
      UserMailer.delay.sponsor(user,1)
      UserMailer.delay.sponsor(user,2)
      UserMailer.delay.sponsor(user,3)
      UserMailer.delay.sponsor(user,4)
      UserMailer.delay.sponsor(user,5)
    end

  end

  def before_validation(user)
    user.name.downcase! if user.name_changed?
    user.email1.downcase! if user.email1_changed?
    user.email2.downcase! if user.email2_changed?
  end

  def before_create(user)

    user.close = user.close=="1" || user.close==true ? true : false
    user.money = user.money=="1" || user.money==true ? true : false
    user.comm = user.comm=="1" || user.comm==true ? true : false
    user.mail = user.mail=="1" || user.mail==true ? true : false
    
    user.token=SecureRandom.hex
    user.create_address(:country_id=>29)
    user.create_bank_account

  end

  def before_save(user)
    if user.pwd_changes==true && user.new_password.present?
      user.password=user.new_password
    end
    user.gender_id=0 if user.gender_id==nil
  end

end
