class Admin::SetupsController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.new(params[:user])
    @user.tap do |user|
      user.nick=params[:user][:name]
      user.fullname=params[:user][:name]
      user.password=CFG['fakepass']
      user.email1=CFG['fakemail']
    end
    @user.person=1
    @user.qty=@user.qty.to_i
    if @user.valid?
      while @user.qty > 0
        name=[@user.name,@user.qty].join
        user=User.new(@user.attributes)
        user.tap do |user|
          user.nick=name
          user.fullname=name
          user.name=name
          user.close=@user.close
          user.money=@user.money
          user.comm=@user.comm
          user.mail=@user.mail
        end
        user.save
        @user.qty -= 1
      end
      flash[:success]="Pronto"
      redirect_to :action=>:new
    else
      render :new
    end
  end
end
