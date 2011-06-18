class ContactsController < ApplicationController

  def new
    @contact=Contact.new
  end

  def create
    params[:contact][:sponsor_name]=@sponsor.name
    @contact=Contact.new(params[:contact])
    if @contact.valid?
     SiteMailer.delay.contact(params[:contact])
     flash[:success]="Contato enviado com sucesso!"
     redirect_to :action=>:new
    else
      render :new
    end
  end

end
