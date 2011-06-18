#encoding: UTF-8
class PaymentsController < ApplicationController

  def via 
    conn
    if @bill.status == 0
      redirect_to "#{root_url}/boleto/real.php?bill_id=#{@bill.id}&bill_key=#{@bill.token}" if params[:way] == "boleto"
      redirect_to "#{root_url}/paypal/conn.php?bill_id=#{@bill.id}&bill_key=#{@bill.token}" if params[:way] == "paypal"
    else
      flash[:notice]="Esta conta esta identificada como paga em nosso sistema."
      redirect_to :back
    end
  end
  
  private
  
  def conn
    @bill = Bill.find_by_id_and_token(params[:id],params[:key])
    unless @bill.present?
      redirect_to root_path
    end
  end

end
