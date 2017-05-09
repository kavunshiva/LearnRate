class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  
  private

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

end
