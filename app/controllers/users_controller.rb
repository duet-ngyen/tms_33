class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :load_user, only: [:edit, :update, :show]

  def show
    @user_tasks = Kaminari.paginate_array(@user.user_tasks).page params[:page]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = t"application.notice.user_updated"
      redirect_to user_path
    else
      render "edit"
    end
  end

  private
  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :role, :avatar
  end
end
