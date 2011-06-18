class PayoutObserver < ActiveRecord::Observer
  
  def after_create(payout)
    payout.user.comms.where(:payout_id=>nil,:status=>0).each do |comm|
      comm.payout_id=payout.id
      comm.status=1
      comm.save
    end 
    PayoutMailer.delay.payout_new(payout) if payout.mail==true
  end

  def after_update(payout)
    if (payout.status_was==0 || payout.status_was==2) && payout.status==1
      payout.comms.where(:status=>1).each do |comm|
        comm.status=2
        comm.save
      end
      PayoutMailer.delay.payout_sent(payout) if payout.mail==true
    end
  end

  def after_save(payout)
    clear_cache payout
  end

  def after_destroy(payout)
    clear_cache payout
  end
  
  private

  def clear_cache payout
    Rails.logger.error "Clearing views/payout-stats-#{payout.user_id}"
    Rails.cache.delete "views/payout-stats-#{payout.user_id}"
  end

end
