class Office::SupportsController < Office::ApplicationController
  
  def new
    @support=Support.new
  end

  def create
    params[:support][:user_id]=current_user.id
    @support=Support.new(params[:support])
    if @support.valid?
     SiteMailer.delay.support(params[:support])
     flash[:success]="Seu pedido foi registrado com sucesso!"
     redirect_to :action=>:new
    else
      render :new
    end
  end
  
end
