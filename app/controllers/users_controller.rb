class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show; end

  def index
    @users = User.page(params[:page]).per Settings.pagenate_users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".plscheck"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".login."
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to users_url
  end

  private

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t ".user_not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
