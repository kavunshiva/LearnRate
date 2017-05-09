class SessionsController < ApplicationController
skip_before_action :require_login, only: [:new, :index, :create]

layout false


  def index
    redirect_to new_session_path
  end

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to welcome_index_path
    else
      redirect_to new_session_path
    end
  end

end
