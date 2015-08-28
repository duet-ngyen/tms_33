class SubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @user_subject = @subject.user_subjects.find_by user_id: current_user.id
  end
end
