#encoding: UTF-8
class Office::BankAccountsController < Office::ApplicationController

  def edit
    @bank_account=current_user.bank_account
  end

  def update
    @bank_account=current_user.bank_account
    respond_to do |format|
      if @bank_account.update_attributes(params[:bank_account])
        format.html { redirect_to office_user_path(current_user), notice: 'Conta bancária atualizada com sucesso.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
