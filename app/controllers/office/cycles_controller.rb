class Office::CyclesController < Office::ApplicationController

  
  skip_before_filter :subdomain_filter,:require_login,:modules, :only=>[:info]
  before_filter :preliminar,:except=>[:info]
  
  def index
    @cycles=current_user.cycles.order(:cycle_type_id, "id desc").page(params[:page]).per(10)
  end

  def show

    unless Rails.cache.exist? "views/cycle/#{params[:id]}/user/#{current_user.id}" 
      @cycle=current_user.cycles.includes(:sponsored=>:sponsored).where(:id=>params[:id]).first
      unless @cycle
        redirect_to :index
      end
    end
    
  end

  def info
      @cycle = Cycle.find_by_token(params[:id])
      unless @cycle
         redirect_to :index
      end
      render :layout=>nil
  end

end
