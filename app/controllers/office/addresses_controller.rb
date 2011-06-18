#encoding: UTF-8
class Office::AddressesController < Office::ApplicationController

  def edit
    @address=current_user.address
  end

  def update
    @address=current_user.address
    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to office_user_path(current_user), notice: 'Endereço atualizado com sucesso.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
