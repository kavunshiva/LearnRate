class NewAgeController < ApplicationController
  layout "new_age"
  before_action :authorize_user, except: [:index, :login, :signup]
  skip_before_action :require_login, only: [:index, :login, :signup]

  def index

  end

  def signup
    @user = User.new
  end

end
