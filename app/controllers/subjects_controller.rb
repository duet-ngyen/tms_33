class SubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @user_subject = @subject.user_subjects.find_by user_id: current_user
    @course = Course.find params[:course_id]
  end
end
