class SessionsController < ApplicationController

before_action :authorize_user, except: [:new, :create]
skip_before_action :require_login, only: [:new, :index, :create]



  def index
    redirect_to new_session_path
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to welcome_index_path
    else
      flash[:notice] = "We couldn't find your username and/or password, try again."
      redirect_to new_session_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password_digest)
  end

end
