class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:notice] = t "application.notice.update_success"
    else
      flash[:notice] = t "application.notice.update_not_success"
    end
    redirect_to :back
  end

  private
  def user_subject_params
    params.require(:user_subject).permit :status, :id,
      user_tasks_attributes: [:id, :status]
  end
end
