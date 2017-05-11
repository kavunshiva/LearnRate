class UsersController < ApplicationController

  before_action :authorize_user, except: [:new, :create]
  skip_before_action :require_login, only: [:new, :create]

  layout "new_age", :only => :new


  def index
    @users = User.all.sort_by { |user| user.username }
  end

  def new
    if !session[:user_id] || current_user.admin
      @user = User.new
    else
      redirect_to welcome_index_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    if session[:user_id].to_s == params[:id] || current_user.admin
      @user = User.find_by(id: params[:id])
    else
      flash[:notice] = "You must be either be this user or the admin to edit this user."
      redirect_to users_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if session[:user_id].to_s == params[:id] || current_user.admin
      User.find_by(id: params[:id]).destroy
    else
      flash[:notice] = "You must be either be this user or the admin to edit this user."
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :password_confirmation,
      :admin,
      :first_name,
      :last_name
      )
  end


end
