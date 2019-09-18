class SessionsController < ApplicationController
  def new; end

  def create
    @session = params[:session]
    @user = User.find_by email: @session[:email].downcase
    if @user&.authenticate @session[:password]
      if @user.activated?
        login_user_activated
      else
        warn_not_activated
      end
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def login_user_activated
    log_in @user
    @session[:remember_me] == Settings.check ? remember(@user) : forget(@user)
    redirect_back_or @user
  end

  def warn_not_activated
    message = t ".account_not_activated"
    message += t ".check_mail"
    flash[:warning] = message
    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
