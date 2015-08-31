class Supervisor::ActivitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @activities = Activity.order_created_at.page params[:page]
  end

  def destroy
    if @activity.destroy
      flash[:success] = t "application.notice.activity_deleted"
    else
      flash[:danger] = t "application.notice.not_deleted"
    end
    redirect_to supervisor_activities_path
  end
end
