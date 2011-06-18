class Office::HomeController < Office::ApplicationController

  before_filter :preliminar, :only=>[:products]

  def index

    unless Rails.cache.exist?("views/monit-stats-#{current_user.id}")  
      @level1=User.where(:sponsor_id=>current_user.id).where("id != 1")
      @level2=User.where(:sponsor_id=>@level1.map(&:id))    
      @level3=User.where(:sponsor_id=>@level2.map(&:id))
      @level4=User.where(:sponsor_id=>@level3.map(&:id))
      @level5=User.where(:sponsor_id=>@level4.map(&:id))
      @cycles=current_user.cycles.order(:cycle_type_id, "id desc").limit(1)
    end
    

  end

  def products
  end
  
  def banners
  end
  
end
