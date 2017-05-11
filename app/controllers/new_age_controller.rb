class NewAgeController < ApplicationController
  layout "new_age"
  before_action :authorize_user, except: [:index, :login, :signup]
  skip_before_action :require_login, only: [:index, :login, :signup]

  def index
    create_new_user_or_redirect_if_signed_in
  end

  def signup
    create_new_user_or_redirect_if_signed_in
  end

  def login
    create_new_user_or_redirect_if_signed_in
  end

  private

  def create_new_user_or_redirect_if_signed_in
    if !session[:user_id]
      @user = User.new
    else
      redirect_to welcome_index_path
    end
  end

end
