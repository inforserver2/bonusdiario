class CommObserver < ActiveRecord::Observer

  def after_create comm
    CommMailer.delay.new_comm(comm) if comm.mail==true
  end

  def before_create comm
    if comm.user.status != 1
      false
    else
      true
    end

  end

  def after_save comm
    clear_cache comm
  end

  def after_destroy comm
    clear_cache comm
  end
  
  private

  def clear_cache comm
    Rails.logger.error "Clearing views/comm-stats-#{comm.user_id}"
    Rails.cache.delete "views/comm-stats-#{comm.user_id}"
  end

end
