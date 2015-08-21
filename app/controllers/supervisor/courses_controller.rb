class Supervisor::CoursesController < ApplicationController
  before_action :load_course, except: [:index, :new, :create]

  def show
  end

  def index
    @search = Course.ransack params[:q]
    @courses = Kaminari.paginate_array(@search.result).page params[:page]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:notice] = t"application.notice.course_created"
      redirect_to supervisor_course_path @course
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @course.update_attributes course_params
      flash[:notice] = t "application.notice.course_updated"
      redirect_to supervisor_course_path @course
    else
      render "edit"
    end
  end

  def destroy
    if @course.destroy
      flash[:alert] = t "application.notice.course_deleted"
    else
      flash[:alert] = t "application.notice.course_not_deleted"
    end
    redirect_to supervisor_courses_path
  end

  private
  def course_params
    params.require(:course).permit :title, :description
  end

  def load_course
    @course = Course.find params[:id]
  end
end
