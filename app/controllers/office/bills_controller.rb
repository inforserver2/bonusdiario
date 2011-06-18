class Office::BillsController < ApplicationController

  layout "member"

  def show
    @bill=Bill.find_by_token(params[:token])
    unless @bill.present?
      redirect_to :root
    end
  end

end
