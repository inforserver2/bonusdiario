#encoding: UTF-8
class BillObserver < ActiveRecord::Observer


  def after_create bill
    description="Adesão #{bill.contract.service.name} - #{[bill.contract.user.name,CFG['domain']].join(".")} - fatura##{bill.id}"
    billing=bill.create_bill_setup(:close=>bill.close,:money=>bill.money,:comm=>bill.comm, :mail=>bill.mail)
    if bill.close==true
      bill.update_attributes(:status=>1,:description=>description,:close=>bill.close,:money=>bill.money,:comm=>bill.comm, :mail=>bill.mail) 
    else
     bill.update_attributes(:description=>description) 
    end
    BillMailer.delay.billing(bill) if bill.mail==true

  end

  def after_update bill
    if (bill.status_was==0 || bill.status_was==2) && bill.status==1
      bill.contract.update_attributes(:status=>1, :mail=>bill.mail)
      bill.bill_setup.update_attributes(:money=>bill.money,:comm=>bill.comm, :mail=>bill.mail)
      bill.contract.create_cycle(:cycle_type_id=>bill.contract.service.id, :from_cycle_id=>bill.from_cycle_id, :mail=>bill.mail)
      BillMailer.delay.receipt(bill) if bill.mail==true && bill.money==true
      if bill.comm==true
        if comm_types=CommType.where(:payplan_id=>1)
          bill.comms.create(:comm_type_id=>comm_types[0].id, :value=>( bill.value * comm_types[0].porcentage ), :mail=>bill.mail, :user_id=>bill.contract.user.sponsor.id)
          
          bill.comms.create(:comm_type_id=>comm_types[1].id, :value=>( bill.value * comm_types[1].porcentage ), :mail=>bill.mail, :user_id=>bill.contract.user.sponsor.sponsor.id)

          bill.comms.create(:comm_type_id=>comm_types[2].id, :value=>( bill.value * comm_types[2].porcentage ), :mail=>bill.mail, :user_id=>bill.contract.user.sponsor.sponsor.sponsor.id)
          
          bill.comms.create(:comm_type_id=>comm_types[3].id, :value=>( bill.value * comm_types[3].porcentage ), :mail=>bill.mail, :user_id=>bill.contract.user.sponsor.sponsor.sponsor.sponsor.id)
          
          bill.comms.create(:comm_type_id=>comm_types[4].id, :value=>( bill.value * comm_types[4].porcentage ), :mail=>bill.mail, :user_id=>bill.contract.user.sponsor.sponsor.sponsor.sponsor.sponsor.id)
        end
      end
    end
  end

  def before_create bill
    
    bill.money = bill.money=="1" || bill.money==true ? true : false
    bill.comm = bill.comm=="1" || bill.comm==true ? true : false
    bill.mail = bill.mail=="1" || bill.mail==true ? true : false
    
    bill.token=SecureRandom.hex 

  end

end
