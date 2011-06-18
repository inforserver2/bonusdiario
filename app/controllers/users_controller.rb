#encoding: UTF-8
class UsersController < ApplicationController

  layout "full", :only=>[:new,:create]
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end


  # POST /users
  # POST /users.json
  def create
    
    User.attr_accessible :nick,:email1,:email2,:password, :password_confirmation, :name, :redir_from
    @user = User.new(params[:user])
    @user.fullname=@user.nick
    @user.sponsor_id=@sponsor.id
    @user.mail=true
    respond_to do |format|
      if @user.save
        make_session(@user)
        format.html { redirect_to office_bill_path(:token=>@user.contracts.first.bills.first.token), notice: 'Cadastro concluído com sucesso.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def name_validation
    @user=User.new(:name=>params[:name])
    @user.valid?
    if @user.errors[:name].any?   
      render :text => "#{@user.name} não aceito - informe outro!"
    else
      render :text => "#{@user.name} aceito!"
    end
  end
end
