class ContractObserver < ActiveRecord::Observer
  def after_create(contract)
   contract.bills.create(:value=>contract.service.price, :from_cycle_id=>contract.from_cycle_id, :close=>contract.close, :money=>contract.money, :comm=>contract.comm, :mail=>contract.mail) 
  end

  def after_update(contract)
   if contract.status_was==0 && contract.status==1
    contract.user.update_attributes(:status=>1)
    ContractMailer.delay.activation(contract) if contract.mail==true
   end
  end
end
