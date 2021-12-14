class UsersController < ApplicationController
  def show
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:image, :user_name, :age, :sex, :email, :password)
  end
end
