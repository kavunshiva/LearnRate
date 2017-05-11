class WelcomeController < ApplicationController
  before_action :authorize_user

  def index
    @current_user ||= User.find_by(id: session[:user_id])
  end



end
