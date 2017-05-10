class NewAgeController < ApplicationController
  layout "new_age"
  before_action :authorize_user, except: [:index]
  skip_before_action :require_login, only: [:index]

  def index

  end
end
