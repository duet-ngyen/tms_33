class Supervisor::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = Kaminari.paginate_array(@search.result).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = t "application.notice.user_created"
      redirect_to supervisor_users_path
    else
      render "new"
    end
  end

  def destroy
    @user = User.find params[:id]
    if @user.destroy
      flash[:alert] = t "application.notice.user_deleted"
    else
      flash[:alert] = t "application.notice.user_not_deleted"
    end
    redirect_to supervisor_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :role,
      :password, :password_confirmation
  end
end
