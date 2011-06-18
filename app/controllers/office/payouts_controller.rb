#encoding: UTF-8
class Office::PayoutsController < Office::ApplicationController
  before_filter :preliminar

  def index
    @search = current_user.payouts.metasearch params[:search]
    @payouts = @search.relation.order("id desc").page params[:page]
  end

end
