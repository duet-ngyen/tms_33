class Supervisor::AssignSubjectsController < ApplicationController
  load_and_authorize_resource :course
  before_action :load_course, only: [:edit, :update]

  def edit
    @subjects = Subject.all
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "application.message.course_updated"
      redirect_to [:supervisor, @course]
    else
      @subjects = Subject.all
      render :edit
    end
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def course_params
    params.require(:course).permit subject_ids: []
  end
end
