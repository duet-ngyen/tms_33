class Supervisor::TasksController < ApplicationController
  load_and_authorize_resource
  before_action :load_subject, only: [:show, :edit, :update, :destroy]
  before_action :load_task, only: [:show, :destroy]

  def show
  end

  def destroy
    if @task.destroy
      flash[:alert] = t "application.notice.task_deleted"
    else
      flash[:alert] = t "application.notice.task_not_deleted"
    end
    redirect_to supervisor_subject_path @subject_task
  end

  private
  def load_subject
    @subject_task = Subject.find params[:subject_id]
  end

  def load_task
    @task = Task.find params[:id]
  end
end
