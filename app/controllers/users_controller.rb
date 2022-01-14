class UsersController < ApplicationController
  def show
    @user = current_user
    @restaurants = Restaurant.where(registered_user_id: current_user.id)
    @reviews = Review.where(user_id: current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:image, :user_name, :age, :sex, :email, :password)
  end
end
