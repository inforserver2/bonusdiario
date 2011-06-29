class Office::UsersController < Office::ApplicationController
  
  load "my_tools.rb"
  def show
  end

  def edit
    @user=current_user
  end

  def update
    User.attr_accessible :fullname,:nick,:email2, :phone, :mobile, :skype, :msn, :gtalk, :cpf, :rg, :gender_id, :birth, :avatar, :remove_avatar
    @user=current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to office_user_path(@user), notice: 'Cadastro atualizado com sucesso.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def password_form
    @user=current_user
  end

  def password_update
    @user=current_user
    User.attr_accessible :new_password, :old_password, :new_password_confirmation
    @user=current_user
    @user.pwd_changes=true
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to office_user_path(@user), notice: 'Senha atualizada com sucesso.' }
      else
        format.html { render action: "password_form" }
      end
    end

  end


end
