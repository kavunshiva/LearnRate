class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :location, :current_user, :authorize_user, :logged_in?

  private

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

  def location
    @lesson.unit_location.split("-").map(&:to_i)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:user_id].present?
  end

  def user_valid?(user, password)
    user.try(:authenticate, password)
  end

  def authorize_user
    if !session[:user_id].present?
      flash[:notice] = 'You are not allowed to do that unless you are logged in'
      redirect_to root_path
    end

  end

end
