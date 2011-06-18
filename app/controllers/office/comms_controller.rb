#encoding: UTF-8
class Office::CommsController < Office::ApplicationController

  before_filter :preliminar

  def index
    @search = current_user.comms.metasearch params[:search]
    @comms = @search.relation.order("id desc").page params[:page]
  end

end
