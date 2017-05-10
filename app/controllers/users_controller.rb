class UsersController < ApplicationController

  before_action :authorize_user, except: [:new, :create]
  skip_before_action :require_login, only: [:new, :create]


  layout "new_age", :only => :new


  def index
    @users = User.all.sort_by { |user| user.username }
  end

  def new
    @user = User.new
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
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
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
