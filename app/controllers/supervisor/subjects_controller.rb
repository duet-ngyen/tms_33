class Supervisor::SubjectsController < ApplicationController
  load_and_authorize_resource
  def show
  end

  def index
    @search = Subject.ransack params[:q]
    @subjects = Kaminari.paginate_array(@search.result).page params[:page]
  end

  def new
    @subject = Subject.new
    2.times {@subject.tasks.build}
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:notice] = t "application.notice.subject_created"
      redirect_to supervisor_subjects_path @subjects
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:notice] = t "application.notice.subject_updated"
      redirect_to supervisor_subjects_path @subjects
    else
      render "edit"
    end
  end

  def destroy
    if @subject.destroy
      flash[:alert] = t "application.notice.subject_deleted"
    else
      flash[:alert] = t "application.notice.subject_not_deleted"
    end
    redirect_to supervisor_subjects_path
  end

  private
  def load_subject
    @subject = Subject.find_by id: params[:id]
  end

  def subject_params
    params.require(:subject).permit :title, :description,
      tasks_attributes: [:id, :title, :description, :status, :_destroy]
  end
end
