#encoding: UTF-8
class Admin::BillsController < Admin::ApplicationController

  def index
    @search=Bill.metasearch params[:search]
    @bills=@search.relation.order("id desc").page(params[:page])
  end

  def edit
    @bill=Bill.find(params[:id])
  end  

  def update
    
    @bill=Bill.find(params[:id])
    if @bill.status!=1
      if @bill.update_attributes(params[:bill])
        flash[:success]="Pagamento quitado!"
        redirect_to :back
      else
        flash[:error]="Erro na quitação do pagamento!"
        redirect_to :back
      end
    else
      flash[:error]="Conta não encontrada!"
      redirect_to :admin_bills
    end
  end

end

