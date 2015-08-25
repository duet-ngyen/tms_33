class Supervisor::AssignTraineesController < ApplicationController
  before_action :load_course

  def edit
    @users = User.all
  end

  def update
    if @course.update course_params
      flash[:success] = t "application.message.course_updated"
      redirect_to [:supervisor, @course]
    else
      @users = User.all
      render :edit
    end
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def course_params
    params.require(:course).permit user_ids: []
  end
end
