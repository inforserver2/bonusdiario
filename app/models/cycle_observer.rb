class CycleObserver < ActiveRecord::Observer

  def before_create cycle
    cycle.token=SecureRandom.hex 5
    
    if Cycle.where(:cycle_type_id=>cycle.contract.service.id).empty?
      cycle.sponsor_id=cycle.contract.id
    else
      user = (cycle.contract.user.sponsored.where(:status=>1).count < 3) ? User.upline_qualified?(cycle.contract.user.sponsor) : cycle.contract.user.sponsor
      user_cycle = User.cycle(user, cycle.contract.service.id, 0) 
      cycle.sponsor_id = user_cycle.id
      head = cycle.sponsor

      if head.sponsored.size < 3

        cycle.sponsor_id=head.id
      else
        if head.sponsored.first.sponsored.size < 3
          cycle.sponsor_id=head.sponsored.first.id
        else
          if head.sponsored.last(2).first.sponsored.size < 3
            cycle.sponsor_id=head.sponsored.last(2).first.id
          else
            if head.sponsored.last.sponsored.size < 3
              cycle.sponsor_id=head.sponsored.last.id
            else
              raise "No Cycle Sponsor Available"
            end
          end
        end
      end
    
    end

  
  end

  def after_create cycle
    CycleMailer.delay.new_cycle(cycle)
    sum = cycle.sponsor.sponsor.sponsored.sum(:sponsored_count)

    if [1,2,4,5,7,8,9].include? sum
      cycle.contract.bills.first.comms.create(:comm_type_id=>cycle.contract.service.id, :value=>(cycle.contract.service.price/2), :mail=>true, :user_id=>cycle.sponsor.sponsor.contract.user.id)
    end

    if sum == 7
      cycle.sponsor.sponsor.contract.user.contracts.create(:service_id=>cycle.contract.service.id, :from_cycle_id=>cycle.sponsor.sponsor.id ,:close=>true, :money=>true, :comm=>true, :mail=>false)
   end
   
   if sum == 9
     cycle.sponsor.sponsor.update_attributes(:status=>1)
   end

  end

  def after_update cycle
    if cycle.status_was==0 && cycle.status==1
      CycleMailer.delay.close(cycle)
     # cycle.contract.user.contracts.create(:service_id=>cycle.cycle_type_id+1,:from_cycle_id=>cycle.id ,:close=>true, :money=>true, :comm=>true, :mail=>false) if cycle.cycle_type_id < 5
    end
  end
  

end
