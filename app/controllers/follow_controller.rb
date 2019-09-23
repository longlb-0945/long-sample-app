class FollowController < ApplicationController
  before_action :find_user

  def following
    @title = t "following"
    @users = @user.following.page(params[:page]).per Settings.pagenate_users
    render "users/show_follow"
  end

  def followers
    @title = t "followers"
    @users = @user.followers.page(params[:page]).per Settings.pagenate_users
    render "users/show_follow"
  end

  private

  def find_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t ".user_not_found"
    redirect_to root_path
  end
end
