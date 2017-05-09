class UsersController < ApplicationController

    def create
      user = User.new(user_params).save
      redirect_to root_path
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation)
    end


end
